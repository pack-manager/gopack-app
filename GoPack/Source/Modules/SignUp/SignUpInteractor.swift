protocol SignUpInteractorProtocol {
    func registerUser(with request: SignUpRequest) async
}

final class SignUpInteractor: SignUpInteractorProtocol {
    
    private let userWorker: UserWorkerProtocol
    
    var presenter: SignUpPresenterProtocol?
    
    init(userWorker: UserWorkerProtocol) {
        self.userWorker = userWorker
    }
    
    func registerUser(with request: SignUpRequest) async {
        do {
            let requestDTO = User(name: request.name, email: request.email, password: request.password)
            try await userWorker.registerUser(with: requestDTO)
            presenter?.didRegisterUser()
        } catch NetworkError.detail(let message) {
            presenter?.didFailRegisterUser(errorMessage: message)
        } catch {
            presenter?.didFailRegisterUser(errorMessage: error.localizedDescription)
        }
    }
}
