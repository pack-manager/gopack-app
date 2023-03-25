import Foundation

protocol RestQuery {
    var host: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension RestQuery {
    var parameters: [String: String]? { nil }
    var body: [String: Any]? { nil }
    var headers: [String: String]? { nil }
    
    func asURLRequest() -> URLRequest {
        let url = host
            .appendingPathComponent(path)
            .appendingPathParameters(parameters)

        return URLRequest(url: url)
            .appendingHttpMethod(method)
            .appendingHttpBody(body)
            .appendingHeaders(headers)
            .appendingValues()
    }
}
