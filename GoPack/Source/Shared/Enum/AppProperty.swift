import Foundation

enum AppProperty: String {
    case enpointUserMicroservice = "ENDPOINT_USER_MICROSERVICE"
    case enpointPackMicroservice = "ENDPOINT_PACK_MICROSERVICE"
    
    var url: URL {
        guard let url = URL(string: AppProperty.get(value: rawValue)) else {
            fatalError("URL: \(rawValue) Not Found")
        }
        return url
    }
}


private extension AppProperty {
    static func get<T>(value: String) -> T {
        guard let properties = Bundle.main.infoDictionary else {
            fatalError("Properties Not Found")
        }
        
        guard let appProperties = properties["App Properties"] as? [String: Any] else {
            fatalError("User Properties Not Found")
        }
        
        guard let property = appProperties[value] else {
            fatalError("User Propery Not Found")
        }
        
        guard let value = property as? T else {
            fatalError("Invalid Property Type")
        }
        
        return value
    }
}
