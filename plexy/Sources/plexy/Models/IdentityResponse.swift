//
//  File.swift
//  
//
//  Created by Emir Taletovic on 4/29/20.
//

import Foundation

public struct IdentityResponse: Codable {
    let MediaContainer: IdentityContainer
}

public struct IdentityContainer : Codable {
    let size: Int
    let claimed: Bool
    let machineIdentifier: String
    let version: String
}
