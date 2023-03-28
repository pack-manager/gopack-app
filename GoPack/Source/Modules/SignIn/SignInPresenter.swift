protocol SignInPresenterProtocol: AnyObject {
    func successfullyLoggedIn()
    func loginFailed(errorMessage: String)
}

final class SignInPresenter: SignInPresenterProtocol {

    var view: SignInViewViewDisplayLogicProtocol?
    
    func successfullyLoggedIn() {
        view?.successfullyLoggedIn()
    }
    
    func loginFailed(errorMessage: String) {
        view?.loginFailed(errorMessage: errorMessage)
    }
}
