import SwiftUI

protocol SignInViewViewDisplayLogicProtocol {
    func successfullyLoggedIn()
    func loginFailed(errorMessage: String)
}

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    var interactor: SignInInteractorProtocol?
    
    var body: some View {
        ZStack {
            renderOptionalErrorMessage
            
            if case UIState.success = viewModel.uiState {
                PackagesView()
            } else {
                content
            }
        }
    }
}

// MARK: - UI ELEMENT
private extension SignInView {
    var appName: some View {
        Text("GoPack")
            .foregroundColor(.orange)
            .font(.system(.largeTitle).bold())
            .scaleEffect(1.5)
            .shadow(radius: 1.5)
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
            placeholder: "Entre com a sua senha *"
        )
    }
    
    var signInButton: some View {
        LoadingButtonView(
            action: handleSignIn,
            buttonTitle: "Entrar",
            showProgress: viewModel.uiState == UIState.loading,
            disabled: viewModel.isSignButtonDisabled
        )
    }
    
    var registerLink: some View {
        VStack {
            Text("Ainda não possui conta?")
                .foregroundColor(.gray)
            
            NavigationLink(
                "Realize seu cadastro",
                destination: SignUpViewFactory.create()
            )
        }
    }
    
    var content: some View {
        VStack {
            NavigationView {
                VStack {
                    Spacer()
                    appName
                    Spacer().frame(height: 40)
                    VStack(spacing: 20) {
                        emailField
                        passwordField
                    }
                    Spacer().frame(height: 25)
                    signInButton
                    Spacer()
                    registerLink
                    Spacer().frame(height: 40)
                    
                }
                .padding(.horizontal, 32)
                .navigationTitle("Login")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(viewModel.navigationBarHidden)
            }
        }
    }
    
    var defaultAlertButton: Alert.Button {
        .default(Text("Ok"), action: { viewModel.uiState = .none })
    }
    
    @ViewBuilder var renderOptionalErrorMessage: some View {
        if case UIState.error(let value) = viewModel.uiState {
            Text("")
                .alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text("GoPack"),
                        message: Text(value),
                        dismissButton: defaultAlertButton
                    )
                }
        }
    }
}

// MARK: - REQUEST TO INTERACTOR
extension SignInView {
    func handleSignIn() {
        Task {
            viewModel.uiState = .loading
            await interactor?.signIn(with: SignInRequest(email: viewModel.email, password: viewModel.password))
        }
    }
}

// MARK: - DISPLAY LOGIC EXTENSION
extension SignInView: SignInViewViewDisplayLogicProtocol {
    func successfullyLoggedIn() {
        DispatchQueue.main.async {
            viewModel.uiState = .success
        }
    }
    
    func loginFailed(errorMessage: String) {
        DispatchQueue.main.async {
            viewModel.uiState = .error(errorMessage)
        }
    }
}

// MARK: - PREVIEW
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignInView(viewModel: SignInViewModel())
                .preferredColorScheme($0)
        }
    }
}
