protocol SignUpPresenterProtocol: AnyObject {
    func didRegisterUser()
    func didFailRegisterUser(errorMessage: String)
}

final class SignUpPresenter: SignUpPresenterProtocol {
    
    var view: SignUpViewDisplayLogicProtocol?
    
    func didRegisterUser() {
        view?.didRegisterUser()
    }
    
    func didFailRegisterUser(errorMessage: String) {
        view?.didFailRegisterUser(errorMessage: errorMessage)
    }
}
