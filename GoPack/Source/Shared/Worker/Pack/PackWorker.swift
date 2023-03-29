protocol PackWorkerProtocol {
    func fetchPacks(by userId: String) async throws -> [Pack]
}

final class PackWorker: PackWorkerProtocol {

    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func fetchPacks(by userId: String) async throws -> [Pack] {
        let query = PackQuery(useCase: .getPacksByUserId, userId: userId)
        
        do {
            return try await network.callWithResponse(query, [Pack].self)
        } catch  {
            throw error
        }
    }
}
