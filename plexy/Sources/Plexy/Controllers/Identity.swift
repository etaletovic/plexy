//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/1/20.
//

import Foundation
import Alamofire

public extension Plexy {

    struct Identity {

        private init() {}

        static func getIdentity(completionHandler: @escaping (IdentityResponse?) -> Void) {

            let endpoint = "\(Plexy.baseUrl):\(Plexy.port)/identity"

            let headers: HTTPHeaders = [ .accept("application/json") ]

            Requests.request(endpoint, method: .get, headers: headers, completionHandler: completionHandler)

        }
    }

}
