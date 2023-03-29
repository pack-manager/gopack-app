import SwiftUI

final class PackagesViewModel: ObservableObject {
    @Published var uiState: UIState = .none
    @Published var packs: [Pack] = []
}
