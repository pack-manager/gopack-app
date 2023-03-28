protocol SignInInteractorProtocol {
    func signIn(with request: SignInRequest) async
}

final class SignInInteractor: SignInInteractorProtocol {

    private let userWorker: UserWorkerProtocol
    
    var presenter: SignInPresenterProtocol?
    
    init(userWorker: UserWorkerProtocol) {
        self.userWorker = userWorker
    }
    
    func signIn(with request: SignInRequest) async {
        do {
            let requestDTO = UserSignIn(email: request.email, password: request.password)
            try await userWorker.signIn(with: requestDTO)
            presenter?.successfullyLoggedIn()
        } catch NetworkError.detail(let message)  {
            presenter?.loginFailed(errorMessage: message)
        } catch {
            presenter?.loginFailed(errorMessage: error.localizedDescription)
        }
    }
}
