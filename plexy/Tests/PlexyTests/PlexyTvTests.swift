//
//  File.swift
//  
//
//  Created by Emir Taletovic on 5/26/20.
//

import XCTest
import Foundation
@testable import Plexy

final class PlexyTvTests: XCTestCase {

    override class func setUp() { // 1.
        super.setUp()
        // This is the setUp() class method.
        // It is called before the first test method begins.
        // Set up any overall initial state here.
        Plexy.Auth.token = ProcessInfo.processInfo.environment["plexToken"] ?? ""
        Plexy.Auth.username = ProcessInfo.processInfo.environment["plexUsername"] ?? ""
        Plexy.Auth.password = ProcessInfo.processInfo.environment["plexPassword"] ?? ""
    }

    func testSignIn() {

        let gotResponse = expectation(description: "Got Response")
        var response: SignInResponse?

        Plexy.Tv.Auth.getToken(username: Plexy.Auth.username, password: Plexy.Auth.password) { token in
            response = token
            gotResponse.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        guard let res = response else {
            XCTFail("Response is nil")
            return
        }

        XCTAssertFalse(res.user.authToken.isEmpty)

    }

    func testGetResources() {

        let gotResponse = expectation(description: "Got Response")
        var response: [Resource]?

        Plexy.Tv.Resources.get { resources in
            response = resources
            gotResponse.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        guard let res = response else {
            XCTFail("Response is nil")
            return
        }

        XCTAssertTrue(res.count > 0, "No resources retreived")

        let hasEmptyConnections = res.contains(where: {resource in
            resource.connections.isEmpty
        })

        XCTAssertFalse(hasEmptyConnections, "Connections array not valid")

    }

    func testSerializeOptionSet() {

        let resource = Resource(name: "swift-server",
                                provides: [.server, .client],
                                publicAddress: "8.8.8.8",
                                connections: [
                                    Connection(address: "127.0.0.1",
                                               port: 8080,
                                               uri: "https://swift.org",
                                               local: true,
                                               relay: true)]
        )

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        guard let data = try? encoder.encode(resource) else {
            XCTFail("encode() failed")
            return
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCaseAndPascalCase

        guard let decoded = try? decoder.decode(Resource.self, from: data) else {
            XCTFail("Failed to decode json")
            return
        }

        XCTAssertTrue(decoded.provides == [.client, .server])
        XCTAssertFalse(decoded.provides == [.client, .server, .player])
    }
}
