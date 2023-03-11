import SwiftUI

@main
struct GoPackApp: App {
    var body: some Scene {
        WindowGroup {
            SignInViewFactory.create()
        }
    }
}
