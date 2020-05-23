import Alamofire
import Foundation

public struct Plexy {

    public static var port: Int = 32400
    public static var baseUrl: String = "http://127.0.0.1"
    public static var token: String = ""

    public static func configure(baseUrl: String, port: Int) {

        Plexy.port = port
        Plexy.baseUrl = baseUrl

    }
}
