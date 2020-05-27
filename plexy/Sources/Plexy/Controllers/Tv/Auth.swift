//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/1/20.
//

import Foundation
import Alamofire

public extension Plexy.Tv {

    struct Auth {

        private init() {}

        public static func getToken(username: String,
                                    password: String,
                                    completionHandler: @escaping (SignInResponse?) -> Void) {
            let endpoint = "https://plex.tv/users/sign_in.json"
            let headers: HTTPHeaders = [
                .accept("application/json"),
                .contentType("application/x-www-form-urlencoded"),
                .init(name: "X-Plex-Product", value: Plexy.productId),
                .init(name: "X-Plex-Client-Identifier", value: Plexy.clientIdentifier)
            ]

            let parameters = [
                "user[login]": username,
                "user[password]": password
            ]

            Requests.request(endpoint,
                             method: .post,
                             parameters: parameters,
                             headers: headers,
                             completionHandler: completionHandler)
        }
    }
}
