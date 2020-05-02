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
        
        public static func getServers(token: String, completionHandler: @escaping (ServersResponse?) -> Void) {
            
            let endpoint = "\(plexy.baseUrl):\(plexy.port)/servers"
            
            let headers: HTTPHeaders = [
                .accept("application/json"),
                .init(name: "X-Plex-Token", value: token)
                
            ]
            
            Requests.request(endpoint, method: .get, headers: headers, completionHandler: completionHandler)
            
        }
    }
}
