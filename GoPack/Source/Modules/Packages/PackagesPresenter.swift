protocol PackagesPresenterProtocol {
    func didFetchPackages(packs: [Pack])
    func didFailFetchPackages(errorMessage: String)
}

final class PackagesPresenter: PackagesPresenterProtocol {

    var view: PackagesViewDisplayLogicProtocol?
    
    func didFetchPackages(packs: [Pack]) {
        view?.didFetchPackages(packs: packs)
    }
    
    func didFailFetchPackages(errorMessage: String) {
        view?.didFailFetchPackages(errorMessage: errorMessage)
    }
}
