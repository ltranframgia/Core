import Alamofire

enum AppRouter: URLRequestConvertible {
    case getAppInfo(parameters: Parameters?)

    var method: HTTPMethod {
        switch self {
        case .getAppInfo:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getAppInfo :
            return "/app/infos"
        }
    }

    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Config.baseUrl.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .getAppInfo(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}

enum UploadRouter: UploadURLConvertible {

    case uploadAvatar(dataUpLoadInfo: [DataUpLoad]?, parameters: Parameters?)

    var path: String {

        switch self {
        case .uploadAvatar :
            return "/"
        }
    }

    // MARK: URLConvertible
    func asURL() throws -> URL {
        let urlString = Config.baseUrl + path

        switch self {
        case .uploadAvatar:
            return try urlString.asURL()
        }
    }

    // MARK: UploadURLConvertible
    func dataUpLoad() -> [DataUpLoad]? {
        switch self {
        case .uploadAvatar(let dataUpLoadInfo, _):
            return dataUpLoadInfo
        }
    }

    func parameters() -> Parameter? {

        switch self {
        case .uploadAvatar( _, let parameters):
            return parameters
        }
    }
}
