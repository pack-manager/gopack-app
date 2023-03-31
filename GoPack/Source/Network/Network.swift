import Foundation

protocol NetworkProtocol {
    typealias NetworkCompletion<T> = (Result<T, NetworkError>) -> Void
    
    func call<X: RestQuery, Y: Codable>(_ query: X, _ body: Y) async throws
    func callWithResponse<T: RestQuery, U: Decodable>(_ query: T, _ decodable: U.Type) async throws -> U
    func callWithResponse<T: RestQuery, U: Codable, Y: Codable>(_ query: T, _ body: Y, _ decodable: U.Type) async throws -> U
}

final class Network: NetworkProtocol {
    static var shared: NetworkProtocol = Network()
    
    func call<X: RestQuery, Y: Codable>(_ query: X, _ body: Y) async throws {
        var urlRequest = query.asURLRequest()
        
        do {
            urlRequest.httpBody = try enconde(value: body)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            switch response.statusCode {
            case 200...299: break
            case 400...422, 522:
                let errorMessage: String = try decode(data)
                throw NetworkError.detail(errorMessage)
            default:
                throw NetworkError.unknown
            }
        } catch {
            throw error
        }
    }
    
    func callWithResponse<T: RestQuery, U: Decodable>(_ query: T, _ decodable: U.Type) async throws -> U {
        let urlRequest = query.asURLRequest()
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return try decode(data)
        } catch let error {
            throw error
        }
    }
    
    func callWithResponse<T: RestQuery, U: Codable, Y: Codable>(_ query: T, _ body: Y, _ decodable: U.Type) async throws -> U {
        var urlRequest = query.asURLRequest()
        
        do {
            urlRequest.httpBody = try enconde(value: body)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return try decode(data)
        } catch let error {
            throw error
        }
    }
}
