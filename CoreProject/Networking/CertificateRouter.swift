import Alamofire

enum CertificateRouter: URLRequestConvertible {
    case testCertificate(parameters: Parameter?)

    var method: HTTPMethod {
        switch self {
        case .testCertificate:
            return .post
        }
    }

    var path: String {
        switch self {
        case .testCertificate:
            return "/authentication/login"
        }
    }

    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
//        let url = try Config.baseUrl.asURL()
        let url = try "https://floating-stream-25740.herokuapp.com".asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .testCertificate(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}
