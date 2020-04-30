//
//  File.swift
//  
//
//  Created by Emir Taletovic on 4/29/20.
//

import Foundation

public struct Identity: Codable {
    let MediaContainer: MediaContainer
}

public struct MediaContainer : Codable {
    let size: Int
    let claimed: Bool
    let machineIdentifier: String
    let version: String
}
