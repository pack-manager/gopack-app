import Foundation

protocol NetworkProtocol {
    typealias NetworkCompletion<T> = (Result<T, NetworkError>) -> Void
    
    func call<T: RestQuery, U: Decodable>(_ query: T, _ decodable: U.Type) async -> Result<U, NetworkError>
}

final class Network: NetworkProtocol {
    static var shared: NetworkProtocol = Network()
    
    func call<T: RestQuery, U: Decodable>(_ query: T, _ decodable: U.Type) async -> Result<U, NetworkError> {
        let urlRequest = query.asURLRequest()
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return handle(data)
        } catch {
            return .failure(.detail(error.localizedDescription))
        }
    }
}
