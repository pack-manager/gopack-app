struct User: Codable {
    var id: String?
    var uid: String?
    var name: String
    var email: String?
    var password: String?
    var isImporter: Bool = false
}
