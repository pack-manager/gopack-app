import SwiftUI

final class SignInViewModel: ObservableObject {
    @Published var uiState: UIState = .none
    @Published var navigationBarHidden = true
    @Published var email: String = ""
    @Published var password: String = ""
    
    var isSignButtonDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
}
