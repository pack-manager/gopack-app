import SwiftUI

final class SignUpViewModel: ObservableObject {
    @Published var uiState: UIState = .none
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    var isSignUpButtonDisabled: Bool {
        name.isEmpty || email.isEmpty || password.isEmpty
    }
    
    var hasPasswordError: Bool {
        password.count < 6
    }
}
