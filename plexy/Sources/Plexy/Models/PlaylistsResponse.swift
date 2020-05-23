//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/1/20.
//

import Foundation

public struct PlaylistsResponse: Codable {
    let mediaContainer: PlaylistsContainer
}

public struct PlaylistsContainer: Codable {
    let size: Int
    let metadata: [Playlist]
}

public struct Playlist: Codable {
    let ratingKey: String
    let key: String
    let guid: String
    let type: String
    let title: String
    let summary: String
    let smart: Bool
    let playlistType: String
    let composite: String
    let viewCount: Int
    let lastViewedAt: Int
    let duration: Int
    let leafCount: Int
    let addedAt: Int
    let updatedAt: Int
}
