import SwiftUI

struct SignUpViewFactory {
    static func create(signInCanNavigateToMainView: Binding<Bool>) -> some View {
        let presenter = SignUpPresenter()
        let userWorker = UserWorker(network: Network.shared)
        let interactor = SignUpInteractor(userWorker: userWorker, currentLoggedUserSync: CurrentLoggedUserSync.shared)
        let viewModel = SignUpViewModel()
        var view = SignUpView(viewModel: viewModel, signInCanNavigateToMainView: signInCanNavigateToMainView)
        
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}
