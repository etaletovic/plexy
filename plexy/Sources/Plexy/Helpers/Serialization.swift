//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/22/20.
//

import Foundation

struct Serialization {
    struct DecodingStrategy {

        private static func toCamelCase(_ value: String) -> String {
            value
                .split(separator: "_", omittingEmptySubsequences: true)
                .map { part in part.capitalized }
                .joined()
                .decapitalized
        }

        static var plexyDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
            .custom { keys in

                let key = keys.last!

                if let intValue = key.intValue {
                    return AnyKey(intValue: intValue)!
                }

                let decoded = toCamelCase(key.stringValue)

                return AnyKey(stringValue: decoded)!
            }
        }
    }

    struct AnyKey: CodingKey {
        var stringValue: String

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?

        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = String(intValue)
        }

    }
}
