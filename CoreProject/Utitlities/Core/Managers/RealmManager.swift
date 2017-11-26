//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import RealmSwift

struct RealmManager {

    static func config() {
        let fileURL = Realm.Configuration.defaultConfiguration.fileURL
        logD("\(String(describing: fileURL))")

        // get schema version
        let schemaVersion = UInt64(Config.dataVersion)

        // create config
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < schemaVersion {
                }
        })

        // set config
        Realm.Configuration.defaultConfiguration = config
    }
}

protocol DetachableObject: AnyObject {
    func detached() -> Self
}

extension Object: DetachableObject {

    func detached() -> Self {
        let detached = type(of: self).init()
        for property in objectSchema.properties {
            guard let value = value(forKey: property.name) else { continue }
            if let detachable = value as? DetachableObject {
                detached.setValue(detachable.detached(), forKey: property.name)
            } else {
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}

//extension List: DetachableObject {
//
//    func detached() -> List<Element> {
//        let result = List<Element>()
//        forEach {
//            result.append($0.detached())
//        }
//        return result
//    }
//}
