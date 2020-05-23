//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/22/20.
//

import Foundation

extension StringProtocol {
    var decapitalized: String { prefix(1).lowercased() + dropFirst() }
}
