protocol SignUpInteractorProtocol {
    func registerUser(with request: SignUpRequest) async
}

final class SignUpInteractor: SignUpInteractorProtocol {
    
    private let userWorker: UserWorkerProtocol
    private let currentLoggedUserSync: CurrentLoggedUserSync
    
    var presenter: SignUpPresenterProtocol?
    
    init(userWorker: UserWorkerProtocol, currentLoggedUserSync: CurrentLoggedUserSync) {
        self.userWorker = userWorker
        self.currentLoggedUserSync = currentLoggedUserSync
    }
    
    func registerUser(with request: SignUpRequest) async {
        do {
            let requestDTO = User(name: request.name, email: request.email, password: request.password)
            let user = try await userWorker.registerUser(with: requestDTO)
            currentLoggedUserSync.user = user
            presenter?.didRegisterUser()
        } catch NetworkError.detail(let message) {
            presenter?.didFailRegisterUser(errorMessage: message)
        } catch {
            presenter?.didFailRegisterUser(errorMessage: error.localizedDescription)
        }
    }
}
