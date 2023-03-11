import Foundation

extension URL {
    private mutating func appendPathParameters(with parameters: [String: String]?) {
        guard let parameters else { return }
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        self = urlComponents?.url ?? self
    }

    func appendingPathParameters(_ parameters: [String: String]?) -> URL {
        var url = self
        url.appendPathParameters(with: parameters)
        return url
    }
}
