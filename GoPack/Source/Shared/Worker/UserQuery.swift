import Foundation

struct UserQuery: RestQuery {
    var host: URL { AppProperty.enpointUserMicroservice.url }
    var path: String { Constants.userMicroserviePath }
    var method: HTTPMethod { .post }
}

private struct Constants {
    static let userMicroserviePath = "/users"
}
