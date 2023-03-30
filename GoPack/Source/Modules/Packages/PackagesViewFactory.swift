import SwiftUI

struct PackagesViewFactory {
    static func create() -> some View {
        let presenter = PackagesPresenter()
        let packWorker = PackWorker(network: Network.shared)
        let interactor = PackagesInteractor(packWorker: packWorker, currentLoggedUserSync: CurrentLoggedUserSync.shared)
        let viewModel = PackagesViewModel()
        var view = PackagesView(viewModel: viewModel)
        
        presenter.view = view
        interactor.presenter = presenter
        view.interactor = interactor
        return view
    }
}
