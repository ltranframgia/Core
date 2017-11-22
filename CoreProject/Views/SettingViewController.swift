//
//  SettingViewController.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {

    // MARK: - IBOutlet

    // MARK: - Varialbes

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setNavTitle(title: "Setting", subtitle: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Setup View

    // MARK: - Call Api

    // MARK: - Actions

    // MARK: - Functions
}
