
import SwiftUI

struct PackCardView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                packName
                packInfo
            }
            Spacer()
            rightArrow
        }
        .padding()
        .frame(idealWidth: .infinity, maxWidth: .infinity)
        .background(roundedRectangle)
        .padding(.horizontal)
    }
}

// MARK: - UI ELEMENT
private extension PackCardView {
    var packName: some View {
        Text("Fone de ouvido")
            .font(.system(size: 18, weight: .bold))
    }
    
    var packInfo: some View {
        HStack {
            Text("IC02234234BR")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
            
            Text("|")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.gray)
            
            Label("1200", systemImage: "brazilianrealsign")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)
        }
    }
    
    var rightArrow: some View {
        Image(systemName: "chevron.right")
            .bold()
            .foregroundColor(.orange)
    }
    
    var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.orange, lineWidth: 1.4)
            .shadow(color: .gray, radius: 2, x: 2.0, y: 2.0)
    }
}

// MARK: - PREVIEW
struct PackCardView_Previews: PreviewProvider {
    static var previews: some View {
        PackCardView()
            .previewLayout(.sizeThatFits)
    }
}
