//
//  LoginViewModel.swift
//  CoreProject
//
//  Created by Henry Tran on 11/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class LoginViewModel: ViewModel {

    // MARK: - Callback
    var updateLoadingStatusCallback: ((Bool?) -> Void)?
    var loginSuccessCallback: ((Bool?) -> Void)?
    var loginErrorCallback: ((ResponseObject?) -> Void)?

    // MARK: - Variables
    fileprivate var isLoading: Bool? {
        didSet {
            updateLoadingStatusCallback?(isLoading)
        }
    }

    var userName: String?
    var passWord: String?

    // MARK: - init
    init() {

    }

    // MARK: - Action
    func login() {
        isLoading = true
        doLogin()
    }

    // MARK: - Call Api
    fileprivate func doLogin() {
        self.loginSuccessCallback?(true)
        //        NetworkManager.request(AppRouter.getAppInfo(parameters: nil)) { [weak self] (responseObject) in
        //
        //            defer {
        //                self?.isLoading = false
        //            }
        //
        //            guard let strongSelf = self else { return }
        //
        //            if responseObject?.result == .success {
        //                strongSelf.loginSuccessCallback?(true)
        //
        //            } else if responseObject?.result == .error {
        //                strongSelf.loginErrorCallback?(responseObject)
        //            }
        //
        //        }
    }

}

class LoginFBViewModel: ViewModel {

    // MARK: - Callback
    var updateLoadingStatusCallback: ((Bool?) -> Void)?
    var loginSuccessCallback: ((Bool?) -> Void)?
    var loginErrorCallback: ((ResponseObject?) -> Void)?

    // MARK: - Variables
    fileprivate var isLoading: Bool? {
        didSet {
            updateLoadingStatusCallback?(isLoading)
        }
    }

    // MARK: - init
    init() {

    }

    // MARK: - Action
    func login() {
        isLoading = true
        doLogin()
    }

    // MARK: - Call Api
    fileprivate func doLogin() {
        self.loginSuccessCallback?(true)
    }

}
