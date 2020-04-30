import Alamofire
import Foundation

public struct plexy {
    
    public static var port: Int = 32400
    public static var baseUrl: String = "http://127.0.0.1"
    
    public static func getIdentity(completionHandler: @escaping (Identity?) -> Void) {
        
        let endpoint = "\(plexy.baseUrl):\(plexy.port)/identity"
        
        let headers: HTTPHeaders = [ .accept("application/json") ]
        
        request(endpoint, method: .get, headers: headers, completionHandler: completionHandler)

    }
    
    public static func configure(baseUrl: String, port: Int) {
        plexy.port = port;
        plexy.baseUrl = baseUrl;
    }
    
    public static func getToken(username: String, password: String, completionHandler: @escaping (SignInResponse?) -> Void) {
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
        
        request(endpoint, method: .post, parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    
    private static func request<T: Codable>(_ convertible: URLConvertible, method: HTTPMethod = .get, encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default, headers: HTTPHeaders? = nil, completionHandler: @escaping (T?) -> Void) {
        request(convertible, method: method, parameters: nil as PlexyDummy?, encoder: encoder, headers: headers, completionHandler: completionHandler)
    }
    
    private static func request<T: Codable, Parameters: Encodable>(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default, headers: HTTPHeaders? = nil, completionHandler: @escaping (T?) -> Void) {
        
        AF.request(convertible, method: method, parameters: parameters, headers: headers)
            .responseDecodable(of: T.self) {
                completionHandler(try? $0.result.get())
        }
    }
}
