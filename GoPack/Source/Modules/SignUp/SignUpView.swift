import SwiftUI

protocol SignUpViewDisplayLogicProtocol {
    func didRegisterUser()
    func didFailRegisterUser(errorMessage: String)
}

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    var interactor: SignUpInteractorProtocol?
    
    var body: some View {
        ZStack {
            renderOptionalErrorMessage
            
            if case UIState.success = viewModel.uiState {
                PackagesView()
            } else {
                VStack {
                    Spacer()
                    screenTitle
                    VStack(alignment: .center, spacing: 20) {
                        nameField
                        emailField
                        passwordField
                    }
                    Spacer().frame(height: 25)
                    signUpButton
                    Spacer()
                }
                .padding(.horizontal, 32)
            }
        }
    }
}

// MARK: - UI ELEMENT
private extension SignUpView {
    var screenTitle: some View {
        Text("Cadastro")
            .foregroundColor(Color("BlackAndWhite"))
            .foregroundColor(.black)
            .font(.system(.largeTitle).bold())
    }
    
    var nameField: some View {
        InputFieldView(text: $viewModel.name,
                       placeholder: "Entre com o seu nome *",
                       keyboard: .alphabet)
    }
    
    var emailField: some View {
        InputFieldView(text: $viewModel.email,
                       placeholder: "Entre com o seu e-mail *",
                       keyboard: .emailAddress,
                       autocapitalization: .never)
    }
    
    var passwordField: some View {
        InputFieldView(
            text: $viewModel.password,
            isSecureField: true,
            placeholder: "Entre com a sua senha *",
            hasFailure: viewModel.hasPasswordError,
            errorMessage: "Senha precisa ter ao menos 6 caracteres"
        )
    }
    
    var signUpButton: some View {
        LoadingButtonView(
            action: registerUser,
            buttonTitle: "Confirmar",
            showProgress: viewModel.uiState == UIState.loading,
            disabled: viewModel.isSignUpButtonDisabled
        )
    }
    
    var defaultAlertButton: Alert.Button {
        .default(Text("Ok"), action: { viewModel.uiState = .none })
    }
    
    @ViewBuilder var renderOptionalErrorMessage: some View {
        if case UIState.error(let value) = viewModel.uiState {
            Text("")
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text("VenturaHR"),
                        message: Text(value),
                        dismissButton: defaultAlertButton
                    )
                }
        }
    }
}

// MARK: - REQUEST TO INTERACTOR
extension SignUpView {
    func registerUser() {
        Task {
            viewModel.uiState = .loading
            await interactor?.registerUser(with: SignUpRequest(name: viewModel.name,
                                                               email: viewModel.email,
                                                               password: viewModel.password))
        }
    }
}

// MARK: - DISPLAY LOGIC EXTENSION
extension SignUpView: SignUpViewDisplayLogicProtocol {
    func didRegisterUser() {
        DispatchQueue.main.async {
            viewModel.uiState = .success
        }
    }
    
    func didFailRegisterUser(errorMessage: String) {
        DispatchQueue.main.async {
            viewModel.uiState = .error(errorMessage)
        }
    }
}


// MARK: - PREVIEW
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignUpView(viewModel: SignUpViewModel())
                .preferredColorScheme($0)
        }
    }
}
