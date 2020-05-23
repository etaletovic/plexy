//
//  File.swift
//  
//
//  Created by Emir Taletovic on 4/29/20.
//

import Foundation

public struct SignInResponse: Codable {
    let user: User
}

public struct User: Codable {
    let identifier: Int64
    let uuid: String
    let email: String
    let joinedAt: String
    let username: String
    let title: String
    let thumb: String
    let hasPassword: Bool
    let authToken: String
    let authenticationToken: String
}
