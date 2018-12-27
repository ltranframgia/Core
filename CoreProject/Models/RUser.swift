//import Foundation
//import RealmSwift
//import SwiftyJSON
//
//class RUser: Object {
//
//    @objc dynamic var id: String?
//
//    @objc dynamic var firstName: String?
//
//    @objc dynamic var lastName: String?
//
//    @objc dynamic var email: String?
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
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
//    }
//}
//
//
//
