import Foundation

enum NetworkError: Error {
    case dataNotFound
    case decodeFailure(_ detail: String)
    case detail(_ detail: String)
    case loggedOut
    case unknown
}

extension NetworkProtocol {
    func handle<U: Decodable>(_ data: Data?) -> Result<U, NetworkError> {
        guard let data else { return .failure(.dataNotFound) }
        
        do {
            let decoded = try JSONDecoder().decode(U.self, from: data)
            return .success(decoded)
        } catch let decodeError {
            return .failure(.decodeFailure(decodeError.localizedDescription))
        }
    }
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .loggedOut: return "User not Authenticated"
        case .dataNotFound: return "No data Found"
        case let .decodeFailure(detail): return "Decode Failure: \(detail)"
        case let .detail(detail): return "Error Detail: \(detail)"
        default:
            return "Unknown error"
        }
    }
}
