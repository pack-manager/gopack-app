final class CurrentLoggedUserSync {
    
    static let shared = CurrentLoggedUserSync()
    var user: User?
    
    private init() {}
}
