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
}
