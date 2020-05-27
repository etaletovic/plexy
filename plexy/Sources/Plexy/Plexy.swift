import Alamofire
import Foundation

public struct Plexy {

    struct Auth {
        public static var token: String = ""
        public static var username: String = ""
        public static var password: String = ""
    }

    public static var port: Int = 32400
    public static var baseUrl: String = "http://127.0.0.1"
    public static var productId: String = "plexy"
    public static var clientIdentifier: String = "plexy"

    public static func configure(baseUrl: String, port: Int) {

        Plexy.port = port
        Plexy.baseUrl = baseUrl

    }
}
