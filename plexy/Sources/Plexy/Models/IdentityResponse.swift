//
//  File.swift
//  
//
//  Created by Emir Taletovic on 4/29/20.
//

public struct IdentityResponse: Codable {
    let mediaContainer: IdentityContainer
}

public struct IdentityContainer: Codable {
    let size: Int
    let claimed: Bool
    let machineIdentifier: String
    let version: String
}
