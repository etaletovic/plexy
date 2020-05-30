//
//  File.swift
//  
//
//  Created by Emir Taletovic on 4/29/20.
//

import Foundation

public struct Resource: Codable {
    let name: String
    let provides: String
    let publicAddress: String
    let connections: [Connection]
}

public struct Connection: Codable {
    let address: String
    let port: Int
    let uri: String
    let local: Bool
    let relay: Bool
    let ipv6: Bool
}
