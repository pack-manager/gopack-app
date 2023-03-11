protocol SignInInteractorProtocol {}

final class SignInInteractor: SignInInteractorProtocol {
    weak var presenter: SignInPresenterProtocol?
}
