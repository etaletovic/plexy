import Alamofire
import Foundation

struct plexy {
    
    static let port: Int = 32400
    static let base: String = "http://127.0.0.1"
    
    static func getIdentity(completionHandler: @escaping (Identity?) -> Void) {
        
        let endpoint = "\(plexy.base):\(plexy.port)/identity"
        
        let headers: HTTPHeaders = [ .accept("application/json") ]
        
//        AF.request(endpoint, headers: headers).responseDecodable(of: Identity.self) {
//            completionHandler(try? $0.result.get())
//        }
        
        request(endpoint, method: .get, headers: headers, completionHandler: completionHandler)

    }
    
    static func getToken(username: String, password: String, completionHandler: @escaping (SignInResponse?) -> Void) {
        let endpoint = "https://plex.tv/users/sign_in.json"
        let headers: HTTPHeaders = [
            .accept("application/json"),
            .contentType("application/x-www-form-urlencoded"),
            .init(name: "X-Plex-Version", value: "1.0.0"),
            .init(name: "X-Plex-Product", value: "plexy"),
            .init(name: "X-Plex-Client-Identifier", value: "plexy"),
        ]
        
        let parameters = [
            "user[login]": username,
            "user[password]": password,
        ]
        
//        AF.request(endpoint, method: .post, parameters: parameters, headers: headers)
//            .responseDecodable(of: SignInResponse.self) {
//                completionHandler(try? $0.result.get())
//        }
//
        request(endpoint, method: .post, parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    
    static func request<T: Codable>(_ convertible: URLConvertible, method: HTTPMethod = .get, encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default, headers: HTTPHeaders? = nil, completionHandler: @escaping (T?) -> Void) {
        request(convertible, method: method, parameters: nil as PlexyDummy?, encoder: encoder, headers: headers, completionHandler: completionHandler)
    }
    
    static func request<T: Codable, Parameters: Encodable>(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default, headers: HTTPHeaders? = nil, completionHandler: @escaping (T?) -> Void) {
        
        AF.request(convertible, method: method, parameters: parameters, headers: headers)
            .responseDecodable(of: T.self) {
                completionHandler(try? $0.result.get())
        }
    }
    
}
