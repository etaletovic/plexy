//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/1/20.
//

import Foundation
import Alamofire

public extension plexy {
    
    struct Servers {
        
        private init() {}
        
        public static func getServers(token: String = "", completionHandler: @escaping (ServersResponse?) -> Void) {
            
            let authToken = token.isEmpty ? plexy.token : token

            let endpoint = "\(plexy.baseUrl):\(plexy.port)/servers"
            
            let headers: HTTPHeaders = [
                .accept("application/json"),
                .init(name: "X-Plex-Token", value: authToken)
                
            ]
            
            Requests.request(endpoint, method: .get, headers: headers, completionHandler: completionHandler)
            
        }
    }
}
