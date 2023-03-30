final class CurrentLoggedUserSync {
    
    static let shared = CurrentLoggedUserSync()
    var user: User
    
    private init() {
        user = User()
    }
    
    func update(userData: User) {
        user = userData
    }
}
