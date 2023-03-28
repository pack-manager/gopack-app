import Foundation

struct UserQuery {
    var useCase: UserMicroserviceEndpoint
    var httpMethod: HTTPMethod = .post
}

extension UserQuery: RestQuery {
    var host: URL { AppProperty.enpointUserMicroservice.url }
    var path: String { useCase.path }
    var method: HTTPMethod { httpMethod } 
}

enum UserMicroserviceEndpoint {
    case signUp
    case signIn
    
    var path: String {
        switch self {
        case .signUp: return "/users"
        case .signIn: return "/users/login"
        }
    }
}
