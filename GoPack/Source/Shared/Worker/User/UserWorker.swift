protocol UserWorkerProtocol {
    func registerUser(with request: User) async throws -> User
    func signIn(with request: UserSignIn) async throws
}

final class UserWorker: UserWorkerProtocol {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func registerUser(with request: User) async throws -> User {
        let query = UserQuery(useCase: .signUp)
        
        do {
            return try await network.callWithResponse(query, request)
        } catch  {
            throw error
        }
    }
    
    func signIn(with request: UserSignIn) async throws {
        let query = UserQuery(useCase: .signIn)
        
        do {
            try await network.call(query, request)
        } catch  {
            throw error
        }
    }
}
