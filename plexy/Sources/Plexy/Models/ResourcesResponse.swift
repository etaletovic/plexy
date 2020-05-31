//
//  File.swift
//  
//
//  Created by Emir Taletovic on 4/29/20.
//

import Foundation

public struct Resource: Codable {
    public let name: String
    public let provides: ProvidesOptions
    public let publicAddress: String
    public let connections: [Connection]

    public struct Connection: Codable {
        public let address: String
        public let port: Int
        public let uri: String
        public  let local: Bool
        public let relay: Bool
    }

    enum CodingKeys: String, CodingKey {
        case name, provides, publicAddress, connections
    }
}

public extension Resource {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)
        self.publicAddress = try container.decode(String.self, forKey: .publicAddress)
        self.connections = try container.decode([Connection].self, forKey: .connections)

        var newProvides: ProvidesOptions = .none

        try container
            .decode(String.self, forKey: .provides)
            .split(separator: ",")
            .map({part in ProvidesOptions.getOptionBy(name: String(part)) })
            .forEach({ value in newProvides.insert(value) })

        self.provides = newProvides
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.name, forKey: .name)
        try container.encode(self.publicAddress, forKey: .publicAddress)
        try container.encode(self.connections, forKey: .connections)
        try container.encode(self.provides.toCsv(), forKey: .provides)
    }
}

public struct ProvidesOptions: OptionSet, Codable {

    public init(rawValue: Int) {
        self.rawValue = rawValue
        self.stringValue = String(rawValue)
    }

    public init(rawValue: Int, stringValue: String) {
        self.rawValue = rawValue
        self.stringValue = stringValue
    }

    public let rawValue: Int
    let stringValue: String

    public static let server       = ProvidesOptions(rawValue: 1 << 0, stringValue: "server")
    public static let player       = ProvidesOptions(rawValue: 1 << 1, stringValue: "player")
    public static let pubSubPlayer = ProvidesOptions(rawValue: 1 << 2, stringValue: "pubsub-player")
    public static let controller   = ProvidesOptions(rawValue: 1 << 3, stringValue: "controller")
    public static let client       = ProvidesOptions(rawValue: 1 << 4, stringValue: "client")

    public static let all: ProvidesOptions = [.server, .player, .pubSubPlayer, .controller, .client]
    public static let none: ProvidesOptions = []

    private static let allOptionsList: [ ProvidesOptions ] = [.server, .player, .pubSubPlayer, .controller, .client]

    public static func getOptionBy(name: String) -> ProvidesOptions {
        allOptionsList.first(where: { opt in
            opt.stringValue.lowercased() == name.lowercased()
        }) ?? none
    }

    public func toCsv() -> String {
        ProvidesOptions.allOptionsList
            .filter({ opt in self.contains(opt) })
            .map({ opt in opt.stringValue })
            .joined(separator: ",")
    }
}
