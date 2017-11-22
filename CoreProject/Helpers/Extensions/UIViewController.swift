//
//  UIViewController.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/17/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

extension UIViewController {
    var mainViewController: MainViewController? {
        if let _mainViewController = self.tabBarController as? MainViewController {
            return _mainViewController
        }

        return self.view.window?.rootViewController as? MainViewController
    }
}

extension UINavigationController {

    func navigationBarDefault() {
//        self.navigationBar.isTranslucent = false
//        self.navigationBar.barStyle = .black
//        self.navigationBar.barTintColor = UIColor.purple1
    }
}
