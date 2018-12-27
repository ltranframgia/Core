//import Foundation
//import RealmSwift
//import SwiftyJSON
//
//class User: Object {
//
//    var id: String?
//
//    var firstName: String?
//
//    var lastName: String?
//
//    var fullName: String?
//
//    var email: String?
//
//    var gender: Bool?
//
//    // MARK: - Init
//    convenience init?(jsonObject: Any?) {
//        guard let jsonData = jsonObject else { return nil }
//        self.init()
//
//        // parse json
//        let json = JSON(jsonData)
//        self.parseJson(json)
//    }
//
//    convenience init?(json: JSON?) {
//        guard let _json = json else { return nil }
//        self.init()
//
//        // parse json
//        self.parseJson(_json)
//    }
//
//    func parseJson(_ json: JSON) {
//        self.id = json[JSONKey.id].string
//        self.firstName = json[JSONKey.firstName].string
//        self.lastName = json[JSONKey.lastName].string
//        self.email = json[JSONKey.email].string
//        self.gender = json[JSONKey.gender].bool
//    }
//
//    func updateData() {
//        self.fullName = (self.firstName ?? "") + (self.lastName ?? "")
//    }
//
//    static func fromCustomer(jsonObject: Any?) -> User? {
//
//        guard let jsonData = jsonObject else { return nil }
//
//        // parse json
//        let json = JSON(jsonData)
//
//        return User(jsonObject: json[JSONKey.customer].object)
//    }
//
//}
//
//
//
