////
////  Created by Henry Tran
////  Copyright © 2017 THL. All rights reserved.
////
//
//import RealmSwift
//
//struct RealmManager {
//
//    static func config() {
//        let fileURL = Realm.Configuration.defaultConfiguration.fileURL
//        logD("\(String(describing: fileURL))")
//
//        // get schema version
//        let schemaVersion = UInt64(Config.dataVersion)
//
//        // create config
//        let config = Realm.Configuration(
//            schemaVersion: schemaVersion,
//            migrationBlock: { _, oldSchemaVersion in
//                if oldSchemaVersion < schemaVersion {
//                }
//        })
//
//        // set config
//        Realm.Configuration.defaultConfiguration = config
//    }
//}
//
//protocol DetachableObject: AnyObject {
//    func detached() -> Self
//}
//
//extension Object: DetachableObject {
//
//    func detached() -> Self {
//        let detached = type(of: self).init()
//        for property in objectSchema.properties {
//            guard let value = value(forKey: property.name) else { continue }
//
//            if let detachable = value as? DetachableObject {
//
//                if let list = detachable as? List<Int>, let detachedList = detached.value(forKey: property.name) as? List<Int> {
//                    detachedList.append(objectsIn: list.toArrayDetached())
//                } else if let list = detachable as? List<Double>, let detachedList = detached.value(forKey: property.name) as? List<Double> {
//                    detachedList.append(objectsIn: list.toArrayDetached())
//                } else if let list = detachable as? List<String>, let detachedList = detached.value(forKey: property.name) as? List<String> {
//                    detachedList.append(objectsIn: list.toArrayDetached())
//                } else if let list = detachable as? List<Object>, let detachedList = detached.value(forKey: property.name) as? List<Object> {
//                    detachedList.append(objectsIn: list.toArrayDetached())
//                } else {
//                    detached.setValue(detachable.detached(), forKey: property.name)
//                }
//
//            } else {
//                detached.setValue(value, forKey: property.name)
//            }
//        }
//        return detached
//    }
//}
//
//extension List: DetachableObject {
//
//    func detached() -> List<Element> {
//        let result = List<Element>()
//
//        forEach {
//            if let detachable = $0 as? DetachableObject,
//                let detached = detachable.detached() as? Element {
//                result.append(detached)
//            } else {
//                result.append($0)
//            }
//        }
//
//        return result
//    }
//
//    func toArrayDetached() -> [Element] {
//        return Array(self.detached())
//    }
//}
//
//extension Array {
//
//    func detached() -> [AnyObject] {
//        let result:[AnyObject] = []
//
//        forEach {
//            if let detachable = $0 as? DetachableObject,
//                let detached = detachable.detached() {
//                result.append(detached)
//            } else {
//                result.append($0)
//            }
//        }
//
//        return result
//    }
//}
//
////extension Results {
////
////    func toArrayDetached() -> [Element] {
////        let result = List<Element>()
////        forEach {
////            result.append($0)
////        }
////
////        return Array(result.detached())
////    }
////}
//
//class StringObject: Object {
//    @objc dynamic var value: String = ""
//
//    convenience init?(valueStr: String?) {
//        guard let _value = valueStr else {
//            return nil
//        }
//
//        self.init()
//        value = _value
//    }
//}
//
//class IntObject: Object {
//    @objc dynamic var value: Int = 0
//
//    convenience init?(valueInt: Int?) {
//        guard let _value = valueInt else {
//            return nil
//        }
//
//        self.init()
//        value = _value
//    }
//}
