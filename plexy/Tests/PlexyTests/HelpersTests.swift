//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/22/20.
//

import Foundation
import XCTest
@testable import Plexy

final class HelpersTests: XCTestCase {

    override class func setUp() { // 1.
        super.setUp()
        // This is the setUp() class method.
        // It is called before the first test method begins.
        // Set up any overall initial state here.
    }

    func testDecapitalize() {

        let word = "Test"

        let decap = word.decapitalized

        XCTAssert(decap == "test")

    }

    func testDecodingStrategy() {

        let json = """
        {
            "Name": "X",
            "Age": 30,
            "Child": {
                "Age": 5,
                "Name": "Y"
            }
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = Serialization.DecodingStrategy.pascalDecodingStrategy

        guard let person = try? decoder.decode(Person.self, from: json) else {
            XCTFail("Failed to deserialize root")
            return
        }

        XCTAssert(person.name == "X")
        XCTAssert(person.age == 30)

        guard let child = person.child else {
            XCTFail("Failed to deserialize inner object")
            return
        }

        XCTAssert(child.name == "Y")
        XCTAssert(child.age == 5)

    }

}

public class Person: Codable {
    public var name: String
    public var age: Int

    public var child: Person?

}
