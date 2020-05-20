//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/1/20.
//

import Foundation
import Alamofire

public extension plexy {
    
    struct Playlists {
        
        private init() {}
        
        static func getAll(token: String = "", completionHandler: @escaping (PlaylistsResponse?) -> Void) {
            
            let authToken = token.isEmpty ? plexy.token : token
            
            let endpoint = "\(plexy.baseUrl):\(plexy.port)/playlists"
            
            let headers: HTTPHeaders = [
                .accept("application/json"),
                .init(name: "X-Plex-Token", value: authToken)
                
            ]
            
            Requests.request(endpoint, method: .get, headers: headers, completionHandler: completionHandler)
            
        }
        
        
        static func get(token: String = "", ratingKey: String, completionHandler: @escaping (PlaylistsResponse?) -> Void) {
            
            let authToken = token.isEmpty ? plexy.token : token
            
            let endpoint = "\(plexy.baseUrl):\(plexy.port)/playlists/\(ratingKey)"
            
            let headers: HTTPHeaders = [
                .accept("application/json"),
                .init(name: "X-Plex-Token", value: authToken)
                
            ]
            
            Requests.request(endpoint, method: .get, headers: headers, completionHandler: completionHandler)
            
        }
        
        static func getItems(token: String = "", ratingKey: String, completionHandler: @escaping (PlaylistItemsResponse?) -> Void) {
            
            let authToken = token.isEmpty ? plexy.token : token

            let endpoint = "\(plexy.baseUrl):\(plexy.port)/playlists/\(ratingKey)/items"
            
            let headers: HTTPHeaders = [
                .accept("application/json"),
                .init(name: "X-Plex-Token", value: authToken)
                
            ]
            
            Requests.request(endpoint, method: .get, headers: headers, completionHandler: completionHandler)
            
        }
    }
}
