import SwiftUI

struct SignInViewFactory {
    static func create() -> some View {
        let presenter = SignInPresenter()
        let userWorker = UserWorker(network: Network.shared)
        let interactor = SignInInteractor(userWorker: userWorker)
        let viewModel = SignInViewModel()
        var view = SignInView(viewModel: viewModel)
        
        presenter.view = view
        interactor.presenter = presenter
        view.interactor = interactor
        return view
    }
}
