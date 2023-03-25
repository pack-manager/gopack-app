import Foundation

enum NetworkError: Error {
    case dataNotFound
    case decodeFailure(_ detail: String)
    case detail(_ detail: String)
    case loggedOut
    case unknown
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

extension NetworkProtocol {
    func enconde<T: Encodable>(value: T) throws -> Data {
        do {
            return try JSONEncoder().encode(value)
        } catch {
            throw NetworkError.detail("Erro ao codificar JSON: \(error.localizedDescription)")
        }
    }
    
    func decode<U: Decodable>(_ data: Data?) throws -> U {
        guard let data else { throw NetworkError.dataNotFound }
        
        do {
            return try JSONDecoder().decode(U.self, from: data)
        } catch let decodeError {
            throw NetworkError.decodeFailure(decodeError.localizedDescription)
        }
    }
}
