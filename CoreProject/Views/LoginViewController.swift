//
//  LoginViewController.swift
//  BaseMVC
//
//  Created by Henry Tran on 6/21/17.
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var infoLabel: UILabel!

    // MARK: - Varialbes
    fileprivate var viewModel: LoginViewModel?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup view model
        self.setupViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoadingIndicator(inView: self.infoLabel, position: .center, offset: 0)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Setup View
    fileprivate func setupViewModel() {

        // init
        viewModel = LoginViewModel()

        // update status
        viewModel?.updateLoadingStatusCallback = { [weak self] (isLoading) in
            DispatchQueue.main.async {
                self?.hideLoadingIndicator()
            }
        }

        // login Success
        viewModel?.loginSuccessCallback = { [weak self] (isLoading) in
            logD("loginSuccess")
            DispatchQueue.main.async {
                self?.mainViewController?.setupMainTabbar()
                self?.dismiss(animated: false) {}
            }
        }

        // login error
        viewModel?.loginErrorCallback = { [weak self] (responseObject) in
            logD("loginError")
            DispatchQueue.main.async {
                self?.handleResponseError(responseObject: responseObject, completion: nil)
            }
        }
    }

    // MARK: - Actions
    @IBAction func touchButtonLoginAction(_ sender: Any) {

        // login
        self.viewModel?.login()
    }

    // MARK: - Functions

}
