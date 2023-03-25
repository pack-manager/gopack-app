import SwiftUI

struct InputFieldView: View {
    
    @Binding var text: String
    var isSecureField: Bool = false
    var placeholder: String = ""
    var keyboard: UIKeyboardType = .default
    var autocapitalization: TextInputAutocapitalization = .words
    var hasFailure: Bool? = nil
    var errorMessage: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            renderTextOrSecureField()
            renderOptionalLabel()
        }
    }
}

private extension InputFieldView {
    @ViewBuilder func renderTextOrSecureField() -> some View {
        if isSecureField {
            SecureField(placeholder, text: $text)
                .foregroundColor(Color("BlackAndWhite"))
                .keyboardType(keyboard)
                .textFieldStyle(CustomInputFieldStyle())
        } else {
            TextField(placeholder, text: $text)
                .foregroundColor(Color("BlackAndWhite"))
                .keyboardType(keyboard)
                .textInputAutocapitalization(autocapitalization)
                .textFieldStyle(CustomInputFieldStyle())
        }
    }
    
    @ViewBuilder func renderOptionalLabel() -> some View {
        if let errorMessage = errorMessage, hasFailure == true, !text.isEmpty {
            Text(errorMessage)
                .foregroundColor(.red)
        }
    }
}

struct InputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            InputFieldView(text: .constant("Texto"))
                .preferredColorScheme($0)
                .padding()
        }
    }
}
