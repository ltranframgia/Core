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
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: XButton!

    // MARK: - Varialbes
    fileprivate var viewModel: LoginViewModelBindable?

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
        if viewModel == nil {
            viewModel = LoginViewModel()
        }

        // bind to
        usernameTextField.bindTo(viewModel?.username)
        passwordTextField.bindTo(viewModel?.password)

        // update status
        viewModel?.loading.onUpdate = { [weak self] (loading) in
            DispatchQueue.main.async {
                if loading?.show == nil {
                    self?.hideLoadingIndicator()
                } else if loading?.type == .center {
                    self?.showLoadingIndicator(inView: self?.loginButton, position: .center, offset: 0)
                }
            }
        }

        // login success
        viewModel?.loginResponse.success.onUpdate = { [weak self] (success) in
            logD("loginSuccess")
            DispatchQueue.main.async {
                self?.mainViewController?.setupMainTabbar()
                self?.dismiss(animated: false) {}
            }
        }

        // login error
        viewModel?.loginResponse.error.onUpdate = { [weak self] (responseObject) in
            logD("loginError")
            DispatchQueue.main.async {
                self?.handleResponseError(responseObject: responseObject, completion: nil)
            }
        }
    }

    // MARK: - Actions
    @IBAction func touchButtonLoginAction(_ sender: Any) {

        // login
        self.viewModel?.loginAction()
//        _ = self.viewModel?.validate(userName: userNameTextField.text, passWord:  passwordTextField.text)
    }

    // MARK: - Functions

}
