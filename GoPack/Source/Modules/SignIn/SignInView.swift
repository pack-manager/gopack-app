import SwiftUI

struct SignInView: View {

    @StateObject var viewModel = SignInViewModel()
    var interactor: SignInInteractorProtocol?
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    Spacer()
                    appName
                    Spacer().frame(height: 40)
                    emailField
                    passwordField
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
}

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
            action: {},
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
                destination: EmptyView()
            )
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignInView()
                .preferredColorScheme($0)
        }
    }
}
