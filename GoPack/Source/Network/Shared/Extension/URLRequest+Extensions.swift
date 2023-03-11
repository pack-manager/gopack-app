import Foundation

extension URLRequest {
    func appendingHttpMethod(_ method: HTTPMethod) -> URLRequest {
        var urlRequest = self
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }

    func appendingHttpBody(_ body: [String: Any]?) -> URLRequest {
        guard let body = body else { return self }
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        var urlRequest = self
        urlRequest.httpBody = bodyData
        return urlRequest
    }

    func appendingHeaders(_ headers: [String: String]?) -> URLRequest {
        guard let headers = headers else { return self }
        var urlRequest = self
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
}
