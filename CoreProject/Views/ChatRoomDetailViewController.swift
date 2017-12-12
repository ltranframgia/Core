//
//  ChatRoomDetailViewController.swift
//  CoreProject
//
//  Created by Henry Tran on 11/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ChatRoomDetailViewController: BaseViewController {

    // MARK: - IBOutlet

    // MARK: - Varialbes

    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
//        self.navigationController?.hidesBottomBarWhenPushed = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.hidesBottomBarWhenPushed = false
    }

    override func viewWillSwipeBack() {

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Setup View
    fileprivate func setupViewModel() {

    }

    // MARK: - Actions
    override func touchBackButtonAction(_ sender: Any) {
//        self.navigationController?.viewControllers.remove(at: self.numberVCInNav! - 2).hidesBottomBarWhenPushed = true
        super.touchBackButtonAction(sender)

    }
    // MARK: - Functions

}
