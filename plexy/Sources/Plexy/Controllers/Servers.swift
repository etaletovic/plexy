//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/1/20.
//

import Foundation
import Alamofire

public extension Plexy {

    struct Servers {

        private init() {}

        public static func getServers(token: String = "", completionHandler: @escaping (ServersResponse?) -> Void) {

            let authToken = token.isEmpty ? Plexy.Auth.token : token

            let endpoint = "\(Plexy.baseUrl):\(Plexy.port)/servers"

            let headers: HTTPHeaders = [
                .accept("application/json"),
                .init(name: "X-Plex-Token", value: authToken)

            ]

            Requests.request(endpoint, method: .get, headers: headers, completionHandler: completionHandler)

        }
    }
}
