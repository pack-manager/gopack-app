import SwiftUI

struct MainView: View {
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            PackagesViewFactory.create()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Home")
                }.tag(0)
            
            Text("Arquivadas")
                .tabItem {
                    Image(systemName: "archivebox")
                    Text("Arquivadas")
                }.tag(1)
        }
        .tint(.orange)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
