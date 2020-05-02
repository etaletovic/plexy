//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/1/20.
//

import Foundation
import Alamofire

public struct Requests {
    public static func request<T: Codable>(_ convertible: URLConvertible, method: HTTPMethod = .get, encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default, headers: HTTPHeaders? = nil, completionHandler: @escaping (T?) -> Void) {
        request(convertible, method: method, parameters: nil as PlexyDummy?, encoder: encoder, headers: headers, completionHandler: completionHandler)
    }
    
    public static func request<T: Codable, Parameters: Encodable>(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default, headers: HTTPHeaders? = nil, completionHandler: @escaping (T?) -> Void) {
        
        AF.request(convertible, method: method, parameters: parameters, headers: headers)
            .responseDecodable(of: T.self) {
                
                var result: T?
                
                do {
                    result = try $0.result.get()
                }
                catch {
                    print(error)
                }
                
                completionHandler(result)
        }
    }
    
}
