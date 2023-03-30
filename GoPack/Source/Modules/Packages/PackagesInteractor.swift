protocol PackagesInteractorProtocol {
    func fetchPacks(with request: PackagesRequest) async
}

final class PackagesInteractor: PackagesInteractorProtocol {
    
    private let packWorker: PackWorkerProtocol
    private let currentLoggedUserSync: CurrentLoggedUserSync
    
    var presenter: PackagesPresenterProtocol?
    
    init(packWorker: PackWorkerProtocol, currentLoggedUserSync: CurrentLoggedUserSync) {
        self.packWorker = packWorker
        self.currentLoggedUserSync = currentLoggedUserSync
    }
    
    func fetchPacks(with request: PackagesRequest) async {
        do {
            print(currentLoggedUserSync)
            let packs = try await packWorker.fetchPacks(by: request.userId)
            presenter?.didFetchPackages(packs: packs)
        } catch NetworkError.detail(let message)  {
            presenter?.didFailFetchPackages(errorMessage: message)
        } catch {
            presenter?.didFailFetchPackages(errorMessage: error.localizedDescription)
        }
    }
}
