//
//  AuthRouter.swift
//  CoreProject
//
//  Created by Henry Tran on 11/30/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Alamofire

enum AuthRouter: URLRequestConvertible {
    
    case login(parameters: Parameters?)

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }

    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Config.baseUrl.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .login(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}
