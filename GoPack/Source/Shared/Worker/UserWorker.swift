protocol UserWorkerProtocol {
    func registerUser(with request: User) async throws
}

final class UserWorker: UserWorkerProtocol {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func registerUser(with request: User) async throws {
        let query = UserQuery()
        
        do {
            try await network.call(query, request)
        } catch  {
            throw error
        }
    }
}
