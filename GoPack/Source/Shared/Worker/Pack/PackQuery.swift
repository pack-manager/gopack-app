import Foundation

struct PackQuery {
    var useCase: PackAPI
    var httpMethod: HTTPMethod = .post
    var userId: String
}

extension PackQuery: RestQuery {
    var host: URL { AppProperty.enpointPackMicroservice.url }
    var path: String { useCase.path }
    var method: HTTPMethod { httpMethod }
    var parameters: [String: String]? {
        var parameters = [String: String]()
        parameters[Constant.Key.userId] = userId
        return parameters
    }
}

enum PackAPI {
    case getPacksByUserId
    
    var path: String {
        switch self {
        case .getPacksByUserId: return "/packs/users"
        }
    }
}

private enum Constant {
    enum Key {
        static let userId = "userId"
    }
}
