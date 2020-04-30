import XCTest
@testable import plexy

final class plexyTests: XCTestCase {
    func testGetIdentity() {
        
        let gotResponse = expectation(description: "Got Response")
        var identity: Identity? = nil
        
        plexy.getIdentity { i in
            identity = i
            gotResponse.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(identity?.MediaContainer)
        
    }
    
    func testSignIn() {
        
        let gotResponse = expectation(description: "Got Response")
        var response: SignInResponse? = nil
        
        plexy.getToken(username: "", password: "") { i in
            response = i
            gotResponse.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(response?.user)
        XCTAssertFalse(response!.user.authToken.isEmpty)
        
    }
    
    static var allTests = [
        ("testGetIdentity", testGetIdentity),
        ("testSignIn", testSignIn),
    ]
}
