protocol PackagesInteractorProtocol {
    func fetchPacks(with request: PackagesRequest) async
}

final class PackagesInteractor: PackagesInteractorProtocol {
    
    private let packWorker: PackWorkerProtocol
    
    var presenter: PackagesPresenterProtocol?
    
    init(packWorker: PackWorkerProtocol) {
        self.packWorker = packWorker
    }
    
    func fetchPacks(with request: PackagesRequest) async {
        do {
            let packs = try await packWorker.fetchPacks(by: request.userId)
            presenter?.didFetchPackages(packs: packs)
        } catch NetworkError.detail(let message)  {
            presenter?.didFailFetchPackages(errorMessage: message)
        } catch {
            presenter?.didFailFetchPackages(errorMessage: error.localizedDescription)
        }
    }
}
