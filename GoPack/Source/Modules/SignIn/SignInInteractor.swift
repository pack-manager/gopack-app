protocol SignInInteractorProtocol {
    func signIn(with request: SignInRequest) async
}

final class SignInInteractor: SignInInteractorProtocol {

    private let userWorker: UserWorkerProtocol
    private let currentLoggedUserSync: CurrentLoggedUserSync
    
    var presenter: SignInPresenterProtocol?
    
    init(userWorker: UserWorkerProtocol, currentLoggedUserSync: CurrentLoggedUserSync) {
        self.userWorker = userWorker
        self.currentLoggedUserSync = currentLoggedUserSync
    }
    
    func signIn(with request: SignInRequest) async {
        do {
            let requestDTO = UserSignIn(email: request.email, password: request.password)
            let user = try await userWorker.signIn(with: requestDTO)
            currentLoggedUserSync.user = user
            presenter?.successfullyLoggedIn()
        } catch NetworkError.detail(let message)  {
            presenter?.loginFailed(errorMessage: message)
        } catch {
            presenter?.loginFailed(errorMessage: error.localizedDescription)
        }
    }
}
