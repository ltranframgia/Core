//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import UserNotifications
import SwiftyJSON

public typealias NotificationName = NSNotification.Name

extension NotificationName {

    public struct Notification {
        public static let didReceivedAtFinishLaunching = NSNotification.Name("NotificationDidReceivedAtFinishLaunching")
        public static let didReceivedAtActiveState = NSNotification.Name("NotificationDidReceivedAtActiveState")
        public static let didReceivedAtInActiveState = NSNotification.Name("NotificationDidReceivedAtInActiveState")
        public static let didReceivedAtBackgroundState = NSNotification.Name("NotificationDidReceivedAtBackgroundState")
    }
}

class NotificationManager {

    // singleton
    static let shared: NotificationManager = NotificationManager()

    var deviceToken: String?
    var userInfo: [AnyHashable: Any]?

    // MARK: - Register
    static func registerNotificationSettings() {

        if #available(iOS 10, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .alert, .sound]) { ( _, _) in
                // Enable or disable features based on authorization.
            }

        } else {
            let notificationSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        }
    }

    static func unregisterForRemoteNotifications() {
        if UIApplication.shared.isRegisteredForRemoteNotifications == true {
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }

    static func registerForRemoteNotifications() {
        if UIApplication.shared.isRegisteredForRemoteNotifications == false {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

    // MARK: - Handle Data
    @discardableResult
    func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: Data) -> Bool {

        // parse token
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})

        // set token
        self.deviceToken = deviceTokenString
        logD(deviceTokenString)
        return true
    }

    func getRemoteNotificationFrom(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        userInfo = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable: Any]
        userInfo?[JSONKey.applicationState] = -1
    }

    func didReceiveRemoteNotification(userInfo: [AnyHashable: Any]) {
        self.userInfo = userInfo
        self.userInfo?[JSONKey.applicationState] = UIApplication.shared.applicationState.rawValue
    }

    func handleNotification() {
        if let payLoad = Payload.fromAps(jsonObject: self.userInfo) {

            if let state = UIApplicationState(rawValue: payLoad.applicationState) {
                switch state {
                case .active:
                    NotificationCenter.default.post(name: NotificationName.Notification.didReceivedAtActiveState, object: nil, userInfo: userInfo)
                case .inactive:
                    NotificationCenter.default.post(name: NotificationName.Notification.didReceivedAtInActiveState, object: nil, userInfo: userInfo)
                case .background:
                    NotificationCenter.default.post(name: NotificationName.Notification.didReceivedAtBackgroundState, object: nil, userInfo: userInfo)
                }
            } else {
                NotificationCenter.default.post(name: NSNotification.Name.Notification.didReceivedAtFinishLaunching, object: nil, userInfo: userInfo)
            }

        }

        // remove
        self.userInfo = nil
    }

    // MARK: - Api
    func doSendDeviceTokenToServer() {
//        guard let deviceToken = self.deviceToken else {
//            return
//        }

//        var paramDevice = Parameter()
//        paramDevice[JSONKey.token] = deviceToken
//        paramDevice[JSONKey.os] = GlobalConfig.platform
//        paramDevice[JSONKey.uuid] = AppInfo.uuidString
//
//        var params = Parameter()
//        params[JSONKey.device] = paramDevice
//
//        // request
//        _ = NetworkManager.request(urlRequest: AppRouter.registerDevice(parameters: params)) { (responseObject) in
//            logD(responseObject)
//        }
    }
}

struct Payload {
    var badge: Int?
    var applicationState: Int = -1

    // MARK: - Init
    init?(jsonObject: Any?) {
        guard let jsonData = jsonObject else { return nil }

        // parse json
        let json = JSON(jsonData)
        self.parseJson(json)
    }

    init?(json: JSON?) {
        guard let _json = json else { return nil }

        // parse json
        self.parseJson(_json)
    }

    private mutating func parseJson(_ json: JSON) {
        // self.badge = json[JSONKey.badge].int
    }

    static func fromAps(jsonObject: Any?) -> Payload? {
        guard let jsonData = jsonObject else { return nil }

        let json = JSON(jsonData)
        let apsData = json[JSONKey.aps]

        // payload
        var payLoad = Payload(json: apsData)
        if let applicationState = json[JSONKey.applicationState].int {
            payLoad?.applicationState = applicationState
        }

        return payLoad
    }

}
