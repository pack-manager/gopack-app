import SwiftUI

struct SignInViewFactory {
    static func create() -> some View {
        let presenter = SignInPresenter()
        let interactor = SignInInteractor()
        let viewModel = SignInViewModel()
        var view = SignInView(viewModel: viewModel)
        
        interactor.presenter = presenter
        view.interactor = interactor
        return view
    }
}
