//
//  LoginViewModel.swift
//  CoreProject
//
//  Created by Henry Tran on 11/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

class LoginViewModel: ViewModelComfortable {

    // MARK: - Variables
    var loginRequest: RequestDynamic = RequestDynamic()
    var loading: Dynamic<LoadingType> = Dynamic()
    var userName: Dynamic<String> = Dynamic()
    var passWord: Dynamic<String> = Dynamic()
    var loginAction: Selector = #selector(login(_:))

    // MARK: - init
    init() {

    }

    // MARK: - Action
    @objc func login(_ sender: Any?) {
        userName.value = "1231"
        loading.value = .center
        doLogin()
    }

    // MARK: - Call Api
    fileprivate func doLogin() {
        self.loginRequest.success.value = true
        NetworkManager.request(AppRouter.getAppInfo(parameters: nil)) { [weak self] (responseObject) in

            defer {
                self?.loading.value = nil
            }

            guard let strongSelf = self else { return }

            if responseObject?.result == .success {
                strongSelf.loginRequest.success.value = true

            } else if responseObject?.result == .error {
                strongSelf.loginRequest.error.value = responseObject
            }
        }
    }

}

class LoginFBViewModel: ViewModelComfortable {

    // MARK: - Variables
    var loginRequest: RequestDynamic = RequestDynamic()
    var loading: Dynamic<LoadingType> = Dynamic()

    // MARK: - init
    init() {

    }

    // MARK: - Action
    func login() {
        loading.value = .center
        doLogin()
    }

    // MARK: - Call Api
    fileprivate func doLogin() {
        loginRequest.success.value = true
    }

}
