import XCTest
@testable import plexy


final class plexyTests: XCTestCase {
    
    static let token = ""
    
    func testGetIdentity() {
        let gotResponse = expectation(description: "gresp")
        var identity: IdentityResponse? = nil
        
        plexy.Identity.getIdentity { i in
            identity = i
            gotResponse.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(identity?.MediaContainer)
        
    }
    
    func testGetServers() {
        
        let gotResponse = expectation(description: "gresp")
        var response: ServersResponse? = nil
        
        plexy.Servers.getServers(token: plexyTests.token) { i in
            response = i
            gotResponse.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(response == nil)
        
    }

    func testGetPlaylists() {
        
        let gotResponse = expectation(description: "gresp")
        var response: PlaylistsResponse? = nil
        
        plexy.Playlists.getAll(token: plexyTests.token) { i in
            response = i
            gotResponse.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(response == nil)
        
        if(response != nil){
            XCTAssertTrue(response!.MediaContainer.size > 0)
            XCTAssertTrue(response!.MediaContainer.Metadata.count > 0)
        }

    }
    
    func testGetPlaylistItems() {
        
        let gotResponse = expectation(description: "gresp")
        var response: PlaylistItemsResponse? = nil
        
        plexy.Playlists.getItems(token: plexyTests.token, ratingKey: "10") { i in
            response = i
            gotResponse.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(response == nil)
        
        if(response != nil){
            XCTAssertTrue(response!.MediaContainer.size > 0)
            XCTAssertTrue(response!.MediaContainer.Metadata.count > 0)
        }

    }
    
    func testSignIn() {
        
        let gotResponse = expectation(description: "Got Response")
        var response: SignInResponse? = nil
        
        plexy.Auth.getToken(username: "", password: "") { i in
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
