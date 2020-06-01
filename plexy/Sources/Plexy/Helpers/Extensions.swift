//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/22/20.
//

import Foundation

extension StringProtocol {
    var decapitalized: String { prefix(1).lowercased() + dropFirst() }
    var capitalized: String { prefix(1).uppercased() + dropFirst() }
}

extension JSONDecoder {
    public convenience init(_ keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = keyDecodingStrategy
    }
}

extension JSONDecoder.KeyDecodingStrategy {

    static var convertFromAndUpperCamelSnakeCase: JSONDecoder.KeyDecodingStrategy {
        .custom { keys in

            let key = keys.last!

            if let intValue = key.intValue {
                return AnyKey(intValue: intValue)!
            }

            let decoded = camelCased(key.stringValue)

            return AnyKey(stringValue: decoded)!
        }
    }
    private static func camelCased(_ value: String) -> String {
        value
            .split(separator: "_", omittingEmptySubsequences: true)
            .map { part in part.capitalized }
            .joined()
            .decapitalized
    }

    struct AnyKey: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = String(intValue)
        }
    }
}
