//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/22/20.
//

import Foundation

struct Serialization {
    struct DecodingStrategy {
        static var pascalDecodingStrategy: JSONDecoder.KeyDecodingStrategy {
            .custom { keys in

                let key = keys.last!

                if let intValue = key.intValue {
                    return AnyKey(intValue: intValue)!
                }
                return AnyKey(stringValue: key.stringValue.decapitalized)!
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
