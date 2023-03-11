import SwiftUI

struct LoadingButtonView: View {
    
    var action: () -> Void
    var buttonTitle: String
    var showProgress: Bool = false
    var disabled: Bool = false
    var verticalPadding: CGFloat = 14
    var horizontalPadding: CGFloat = 16
    
    var body: some View {
        ZStack {
            renderButton
            renderProgressView
        }
    }
}

private extension LoadingButtonView {
    var title: String {
        showProgress ? "" : buttonTitle
    }
    
    var backgroundColor: Color {
        disabled ? Color.gray : Color.orange
    }
    
    var isDisabled: Bool {
        disabled || showProgress
    }
    
    var renderButton: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: 25)
                .foregroundColor(.white)
                .font(.system(.title3).bold())
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .background(backgroundColor)
                .cornerRadius(4.0)
        }.disabled(isDisabled)
    }
    
    var renderProgressView: some View {
        ProgressView()
            .scaleEffect(1.2)
            .tint(.white)
            .progressViewStyle(CircularProgressViewStyle())
            .opacity(showProgress ? 1 : 0)
            
    }
}

struct LoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            LoadingButtonView(action: { print("") }, buttonTitle: "Entrar")
                .preferredColorScheme($0)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}

