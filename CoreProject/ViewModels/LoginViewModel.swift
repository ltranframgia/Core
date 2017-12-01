//
//  LoginViewModel.swift
//  CoreProject
//
//  Created by Henry Tran on 11/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol LoginViewModelBindable: LoadingBindable {
    var loginResponse: ResponseDynamic { get }
    var username: Dynamic<String> { get }
    var password: Dynamic<String> { get }
    func loginAction()
}

class LoginViewModel: ViewModelComfortable, LoginViewModelBindable {

    var loginResponse: ResponseDynamic = ResponseDynamic()

    var loading: Dynamic<Loading> = Dynamic()

    var username: Dynamic<String> = Dynamic()

    var password: Dynamic<String> = Dynamic()

    // MARK: - Variables

    // MARK: - init
    init() {

    }

    // MARK: - Action
    func validate(username: String?, password: String?) -> Bool? {

        self.username.value = username
        self.password.value = password

        loginAction()

        return true
    }

    func loginAction() {
        loading.value = (true, .center)
        doLogin()
    }

    // MARK: - Call Api
    fileprivate func doLogin() {
        var params = Parameter()
        params["username"] = "ltranframgia"
        params["password"] = "12345678"

        NetworkManager.request(AuthRouter.login(parameters: params)) { [weak self] (responseObject) in
            logD(responseObject)
            defer {
                self?.loading.value = (false, .center)
            }

            guard let strongSelf = self else { return }

            if responseObject?.result == .success {
                strongSelf.loginResponse.success.value = true

            } else if responseObject?.result == .error {
                strongSelf.loginResponse.error.value = responseObject
            }
        }
    }

}

class LoginFBViewModel: ViewModelComfortable, LoginViewModelBindable {

    var loginResponse: ResponseDynamic = ResponseDynamic()

    var loading: Dynamic<Loading> = Dynamic()

    var username: Dynamic<String> = Dynamic()

    var password: Dynamic<String> = Dynamic()

    // MARK: - init
    init() {

    }

    // MARK: - Action
    func loginAction() {
        loading.value = (true, .center)
        doLogin()
    }

    // MARK: - Call Api
    fileprivate func doLogin() {
        loginResponse.success.value = true
    }

}
