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
    fileprivate var request: NRequest?
    
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
        
        // parameter
        var params = Parameter()
        params[JSONKey.username] = "ltranframgia"
        params[JSONKey.password] = "12345678"
        
        // create router
        let routerInput = AuthRouter.login(parameters: params)
        
        // request
        request?.cancel()
        request = NetworkManager.request(routerInput) { [weak self] (responseObject) in
            logD(responseObject)
            
            defer {
                self?.loading.value = (false, .center)
            }
            
            guard let strongSelf = self else { return }
            
            // check
            if responseObject?.result == .success {
                strongSelf.loginResponse.success.value = true
                
                // save token
                let authHandler = AuthHandler()
                authHandler.parse(jsonObject: responseObject?.data)
                
            } else if responseObject?.result == .error {
                strongSelf.loginResponse.error.value = responseObject
                
                // check statusCode
                 if responseObject?.statusCode == HttpStatusCode.internalServerError {
                 return
                 }
            } else if responseObject?.result == .cancelled {
                
            }
        }
    }

    fileprivate func doUpdateAvatar(_ imageData: Data) {
        
        var dataUpload: [DataUpLoad]?
        let data = (imageData, "avatar", "fileName.png", MimeType.imageJpeg)
        dataUpload = [data]
        
        // create router
        let routerInput = UploadRouter.uploadAvatar(dataUpLoadInfo: dataUpload, parameters: nil)
        
        // upload
        NetworkManager.upload(routerInput, requestBack: { [weak self] (request) in
            self?.request = request
        }, progressHandler: { (currentProgress, totalProgress) in
            
        }) { [weak self] (responseObject) in
            
            defer {
                self?.loading.value = (false, .center)
            }
            
            // guard let strongSelf = self else { return }
            
            // check
            if responseObject?.result == .success {
                
            } else if responseObject?.result == .error {
                
            } else if responseObject?.result == .cancelled {
                
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
