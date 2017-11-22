//
//  UserDao.swift
//  Project
//
//  Created by Henry Tran on 6/24/17.
//  Copyright © 2017 THL. All rights reserved.
//

import RealmSwift

struct UserDao {

    func getUserById(id: Int?) -> RUser? {
        do {
            // Get the default Realm
            let realm = try Realm()
            return realm.object(ofType: RUser.self, forPrimaryKey: id)
        } catch {
            return nil
        }
    }
}
