//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import Alamofire

public typealias ResponseHandler = (ResponseObject?) -> Void
public typealias Parameter = Parameters
public typealias NRequest = Request
public typealias DataUpLoad = (data: Data, name: String, fileName: String, mimeType: String)

protocol UploadURLConvertible: URLConvertible {
    func dataUpLoad() -> [DataUpLoad]?
    func parameters() -> Parameter?
}

struct HeaderKey {
    static let ContentType              = "Content-Type"
    static let Authorization            = "Authorization"
    static let Accept                   = "Accept"
}

struct HeaderValue {
    static let ApplicationJson                     = "application/json"
    static let ApplicationOctetStream              = "application/octet-stream"
    static let ApplicationXWWWFormUrlencoded       = "application/x-www-form-urlencoded"
}

enum RequestResult {
    case success
    case error
    case cancelled
}

public enum HttpStatusCode: Int {
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case notAcceptable = 406
    case requestTimeout = 408
    case conflict = 409
    case internalServerError = 500
    case serviceUnavailable = 503
    case notConnectedToInternet = -1009
    case cancelled = -999
    case timeOut = -1001
    case cannotFindHost = -1003
    case uploadDataError = -90000

    init?(statusCode: Int?) {
        guard let _statusCode = statusCode else {
            return nil
        }

        // init
        self.init(rawValue: _statusCode)
    }
}

public struct ResponseObject {
    let data: AnyObject?
    let statusCode: HttpStatusCode? // code error, incase success
    let result: RequestResult
}

struct NetworkManager {

    fileprivate static var requestCnt: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                if isShowNetworkActivityIndicator == true {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = (requestCnt > 0)
                } else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }

    static var isShowNetworkActivityIndicator: Bool = true

    private static let defaultSessionManager: SessionManager = {

        // defaultHeaders
        var defaultHeaders = SessionManager.defaultHTTPHeaders
        defaultHeaders[HeaderKey.Accept] = HeaderValue.ApplicationJson

        // configuration
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        configuration.timeoutIntervalForRequest = 30

        // sessionManager
        let sessionManager = SessionManager(configuration: configuration)

        return sessionManager
    }()

    // MARK: - Functions
    private static func analyzeResponse(response: DataResponse<Any>, completionHandler: ResponseHandler?) {
        debugPrint(response)

        // http code
        let httpStatusCode = HttpStatusCode(statusCode: response.response?.statusCode)

        switch response.result {
        case .success(let value):
            NetworkManager.successWithValue(data: value as AnyObject, httpStatusCode: httpStatusCode, completionHandler: completionHandler)

        case .failure(let error):
            NetworkManager.failureWithError(error: error, data: response.data, httpStatusCode: httpStatusCode, completionHandler: completionHandler)
        }
    }

    private static func successWithValue(data: AnyObject, httpStatusCode: HttpStatusCode?, completionHandler: ResponseHandler?) {

        // create obj response
        let responseObject = ResponseObject(data: data, statusCode: httpStatusCode, result: RequestResult.success)

        // block
        completionHandler?(responseObject)

    }

    private static func failureWithError(error: Error?, data: Data? = nil, httpStatusCode: HttpStatusCode?, completionHandler: ResponseHandler?) {
        var errorCode: HttpStatusCode? = httpStatusCode
        var requestResult: RequestResult = RequestResult.error
        var errorData: AnyObject? = nil

        // check error code
        if error?._code == NSURLErrorTimedOut {  // Time out
            errorCode = HttpStatusCode(rawValue: NSURLErrorTimedOut)
            requestResult = .error
        } else if error?._code == NSURLErrorCancelled {  // Cancelled
            errorCode = HttpStatusCode(rawValue: NSURLErrorCancelled)
            requestResult = .cancelled
        } else if error?._code == NSURLErrorNotConnectedToInternet { // Not connected to internet
            errorCode = HttpStatusCode(rawValue: NSURLErrorNotConnectedToInternet)
            requestResult = .error
        } else if error?._code == NSURLErrorCannotFindHost { // Can not Find Host
            errorCode = HttpStatusCode(rawValue: NSURLErrorCannotFindHost)
            requestResult = .error
        } else {  // Orther
            if let _data = data {
                do {
                    errorData = try JSONSerialization.jsonObject(with: _data, options: []) as AnyObject
                } catch {
                }
            }
        }

        // create obj response
        let responseObject = ResponseObject(data: errorData, statusCode: errorCode, result: requestResult)

        // block
        completionHandler?(responseObject)
    }

    // MARK: - Request (Public)
    @discardableResult
    static func request(_ request: URLRequestConvertible, completionHandler: ResponseHandler? = nil) -> Request? {
        requestCnt += 1

        // Request
        let manager = NetworkManager.defaultSessionManager

        // AuthHandler
        let authHandler = AuthHandler(baseUrl: Config.baseUrl)
        manager.adapter = authHandler
        // manager.retrier = authHandler

        return manager.request(request).validate().responseJSON { (response) in
            // analyze response
            NetworkManager.analyzeResponse(response: response, completionHandler: completionHandler)
            requestCnt -= 1
        }
    }

    @discardableResult
    static func requestWithoutToken(_ request: URLRequestConvertible, completionHandler: ResponseHandler? = nil) -> Request? {
        requestCnt += 1

        // Request
        let manager = NetworkManager.defaultSessionManager

        // AuthHandler
        manager.adapter = nil
        manager.retrier = nil

        // request
        return manager.request(request).validate().responseJSON { (response) in
            // analyze response
            NetworkManager.analyzeResponse(response: response, completionHandler: completionHandler)
            requestCnt -= 1
        }
    }

    static func upload(_ request: UploadURLConvertible, requestBack: ((Request?) -> Void)?, progressHandler: ((Double, Double) -> Void)? = nil, completionHandler: ResponseHandler? = nil) {
        requestCnt += 1

        // Request
        let manager = NetworkManager.defaultSessionManager

        // AuthHandler
        let authHandler = AuthHandler(baseUrl: Config.baseUrl)
        manager.adapter = authHandler
        // manager.retrier = authHandler

        // data
        let dataUpLoadInfo = request.dataUpLoad() ?? []
        let params = request.parameters()

        // request
        manager.upload(multipartFormData: { multipartFormData in

            // data
            for dataInfo in dataUpLoadInfo {
                multipartFormData.append(dataInfo.data, withName: dataInfo.name, fileName: dataInfo.fileName, mimeType: dataInfo.mimeType)
            }

            // key value
            let _params = self.parseParameters(params)
            for (key, value) in _params {
                if let dataValue = value.data(using: .utf8) {
                    multipartFormData.append(dataValue, withName: key)
                }
            }

        }, to: request) { (encodingResult) in

            switch encodingResult {
            case .success(let upload, _, _):

                // upload
                let uploadRequest = upload.uploadProgress(closure: { (progress) in
                    logD("\(progress) + \(progress.fractionCompleted)")
                    progressHandler?(progress.fractionCompleted, progress.fractionCompleted)
                }).responseJSON { response in
                    // analyze response
                    NetworkManager.analyzeResponse(response: response, completionHandler: completionHandler)
                    requestCnt -= 1
                }

                // pass request back
                requestBack?(uploadRequest)
            case .failure(let errorData):
                let errorCode: HttpStatusCode? = .uploadDataError
                let requestResult: RequestResult = RequestResult.error
                // create obj response
                let responseObject = ResponseObject(data: errorData as AnyObject, statusCode: errorCode, result: requestResult)

                // block
                completionHandler?(responseObject)
                requestCnt -= 1
                break
            }
        }
    }

}

// MARK: - Parse parameters (copy from Alamofire)
extension NetworkManager {

    fileprivate static func parseParameters(_ parameters: Parameters?) -> [(String, String)] {
        guard let _parameters = parameters else {
            return []
        }

        var components: [(String, String)] = []

        for key in _parameters.keys.sorted(by: <) {
            if let value = _parameters[key] {
                components += queryComponents(fromKey: key, value: value)
            }
        }
        return components
    }

    private static func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value)
            }
        } else if let value = value as? NSNumber {
            if value.isBool {
                components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), escape((bool ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }

        return components
    }

    private static func escape(_ string: String) -> String {

        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        var escaped = ""

        if #available(iOS 8.3, *) {
            escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
        } else {
            let batchSize = 50
            var index = string.startIndex

            while index != string.endIndex {
                let startIndex = index
                let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
                let range = startIndex..<endIndex

                let substring = string[range]

                escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)

                index = endIndex
            }
        }

        return escaped
    }
}

extension NSNumber {
    fileprivate var isBool: Bool {
        return CFBooleanGetTypeID() == CFGetTypeID(self)
    }
}
