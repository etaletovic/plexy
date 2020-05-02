import Alamofire
import Foundation

public struct plexy {
    
    public static var port: Int = 32400
    public static var baseUrl: String = "http://127.0.0.1"
    
    public static func configure(baseUrl: String, port: Int) {
        
        plexy.port = port
        plexy.baseUrl = baseUrl
    
    }
}
