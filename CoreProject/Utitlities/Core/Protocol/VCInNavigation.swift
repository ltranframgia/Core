//
//  VCInNavigation.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol VCInNavigation {

    var numberVCInNav: Int? { get}

    func delegateSwipeBack(of viewController: UIViewController?, to delegate: UIViewController?)

    func enableSwipeBack(enable: Bool, for viewController: UIViewController?)

    func viewWillSwipeBack()

    func setNavTitle(title: String?, subtitle: String?)

    func addNavLeftButtonWith(image: UIImage?, target: AnyObject?, action: Selector, tinColor: UIColor?)

    func addNavRightButtonWith(image: UIImage?, target: AnyObject?, action: Selector, tinColor: UIColor?)
}

extension VCInNavigation where Self: UIViewController {

    var numberVCInNav: Int? {
        return self.navigationController?.viewControllers.count
    }

    func delegateSwipeBack(of viewController: UIViewController?, to delegate: UIViewController?) {
        viewController?.navigationController?.interactivePopGestureRecognizer?.delegate = delegate
    }

    func enableSwipeBack(enable: Bool, for viewController: UIViewController?) {
        viewController?.navigationController?.interactivePopGestureRecognizer?.isEnabled = enable
    }

    func setNavTitle(title: String?, subtitle: String?) {
        self.navigationItem.title = title
    }

    func addNavLeftButtonWith(image: UIImage?, target: AnyObject?, action: Selector, tinColor: UIColor?) {
        let leftButton = UIButton.navWithImage(image: image, target: target, action: action, tinColor: tinColor)
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        leftButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: leftButton), animated: false)
    }

    func addNavRightButtonWith(image: UIImage?, target: AnyObject?, action: Selector, tinColor: UIColor?) {
        let rightButton = UIButton.navWithImage(image: image, target: target, action: action, tinColor: tinColor)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: rightButton), animated: false)
    }
}

extension UIButton {

    class func navWithImage(image: UIImage?, target: AnyObject?, action: Selector, tinColor: UIColor?) -> UIButton {
        let navButton: UIButton = UIButton(type: UIButtonType.system)
        navButton.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        navButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navButton.setImage(image, for: UIControlState.normal)
        navButton.tintColor = tinColor ?? UIColor.black
        return navButton
    }
}

extension UIViewController: UIGestureRecognizerDelegate {

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {

            (self as? VCInNavigation)?.viewWillSwipeBack()
        }
        return true
    }
}
