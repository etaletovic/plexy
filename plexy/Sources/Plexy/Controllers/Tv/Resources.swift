//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/1/20.
//

import Foundation
import Alamofire

public extension Plexy.Tv {

    struct Resources {

        private init() {}

        public static func get(completionHandler: @escaping (ServersResponse?) -> Void) {

            let authToken = Plexy.Auth.token

            let endpoint = "\(Plexy.Tv.baseUrl)/resources?includeHttps=1&includeRelay=1"

            let headers: HTTPHeaders = [
                .accept("application/json"),
                .init(name: "X-Plex-Token", value: authToken),
                .init(name: "X-Plex-Product", value: "\(Plexy.productId)"),
                .init(name: "X-Plex-Client-Identifier", value: "\(Plexy.clientIdentifier)"),
                .init(name: "X-Plex-Language", value: "en")

            ]

            Requests.request(endpoint, method: .get, headers: headers, completionHandler: completionHandler)

        }
    }
}
