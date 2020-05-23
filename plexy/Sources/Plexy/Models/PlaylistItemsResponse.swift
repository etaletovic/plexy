//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/1/20.
//

import Foundation

public struct PlaylistItemsResponse: Codable {
    let mediaContainer: PlaylistItemsContainer
}

public struct PlaylistItemsContainer: Codable {
    let size: Int
    let composite: String
    let duration: Int
    let leafCount: Int
    let playlistType: String
    let ratingKey: String
    let smart: Bool
    let title: String
    let metadata: [Item]
}

public struct Item: Codable {
    let ratingKey: String
    let key: String?
    let parentRatingKey: String?
    let grandparentRatingKey: String?
    let guid: String?
    let parentGuid: String?
    let grandparentGuid: String?
    let type: String?
    let title: String?
    let grandparentKey: String?
    let parentKey: String?
    let librarySectionTitle: String?
    let librarySectionID: Int?
    let librarySectionKey: String?
    let grandparentTitle: String?
    let parentTitle: String?
    let originalTitle: String?
    let summary: String?
    let index: Int?
    let parentIndex: Int?
    let ratingCount: Int?
    let thumb: String?
    let parentThumb: String?
    let grandparentThumb: String?
    let playlistItemID: Int?
    let duration: Int?
    let addedAt: Int?
    let updatedAt: Int?
    let media: [Media]

}

public struct Media: Codable {
    let id: Int
    let duration: Int
    let bitrate: Int
    let audioChannels: Int
    let audioCodec: String
    let container: String
    let part: [Part]
}

public struct Part: Codable {
    let id: Int
    let key: String
    let duration: Int
    let file: String
    let size: Int
    let container: String

}
