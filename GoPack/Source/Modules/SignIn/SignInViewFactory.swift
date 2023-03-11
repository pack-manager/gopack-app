import SwiftUI

enum SignInViewFactory {
    static func create() -> some View {
        let presenter = SignInPresenter()
        let interactor = SignInInteractor()
        var view = SignInView()
        
        interactor.presenter = presenter
        view.interactor = interactor
        return view
    }
}
