import SwiftUI

protocol PackagesViewDisplayLogicProtocol {
    func didFetchPackages(packs: [Pack])
    func didFailFetchPackages(errorMessage: String)
}

struct PackagesView: View {
    
    @ObservedObject var viewModel: PackagesViewModel
    var interactor: PackagesInteractorProtocol?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 10)
                    Divider()
                    Spacer().frame(height: 25)
                    VStack(spacing: 16) {
                        PackCardView()
                        PackCardView()
                        PackCardView()
                        PackCardView()
                        PackCardView()
                        PackCardView()
                        PackCardView()
                        PackCardView()
                        PackCardView()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .toolbar {
                leadingToolbarItem
                centerToolbarItem
                trailingToolbarItem
            }
        }.onAppear {
            fetchPackages()
        }
    }
}

// MARK: - UI ELEMENT
private extension PackagesView {
    var leadingToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { }) {
                Image(systemName: "gearshape")
                    .bold()
                    .foregroundColor(.orange)
            }
        }
    }
    
    var centerToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("GoPack")
                .foregroundColor(.orange)
                .font(.system(.title).bold())
                .shadow(radius: 1.5)
        }
    }
    
    var trailingToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { }) {
                Image(systemName: "plus")
                    .bold()
                    .foregroundColor(.orange)
            }
            
            Text("GoPack")
                .foregroundColor(.orange)
                .font(.system(.title).bold())
                .shadow(radius: 1.5)
        }
    }
}

// MARK: - REQUEST TO INTERACTOR
extension PackagesView {
    func fetchPackages() {
        Task {
            let response = await interactor?.fetchPacks(with: PackagesRequest(userId: viewModel.userId))
            print(response)
        }
    }
}

// MARK: - DISPLAY LOGIC EXTENSION
extension PackagesView: PackagesViewDisplayLogicProtocol {
    func didFetchPackages(packs: [Pack]) {}
    
    func didFailFetchPackages(errorMessage: String) {}
}

// MARK: - PREVIEW
struct PackagesView_Previews: PreviewProvider {
    static var previews: some View {
        PackagesView(viewModel: PackagesViewModel())
    }
}
