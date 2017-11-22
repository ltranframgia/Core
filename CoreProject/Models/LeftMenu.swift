//
//  LeftMenu.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

struct LeftMenu {
    var icon: String?
    var name: String?

    static var list: [LeftMenu] = {
        let homeMenu = LeftMenu(icon: nil, name: "Home")
        let settingMenu = LeftMenu(icon: nil, name: "Setting")
        let logoutMenu = LeftMenu(icon: nil, name: "Logout")
        return [homeMenu, settingMenu, logoutMenu]
    }()

}
