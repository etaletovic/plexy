//
//  File.swift
//  
//
//  Created by Emir Taletovic on 4/29/20.
//

import Foundation

public struct ServersResponse: Codable {
    let MediaContainer: ServersContainer
}

public struct ServersContainer: Codable {
    let size: Int
    let Server: [Server]
}

public struct Server: Codable {
    let name: String
    let host: String
    let address: String
    let port: Int
    let machineIdentifier: String
    let version: String
}

