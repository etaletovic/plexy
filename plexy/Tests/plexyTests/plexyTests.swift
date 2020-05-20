import XCTest
import Foundation
@testable import plexy


final class plexyTests: XCTestCase {
    
    override class func setUp() { // 1.
        super.setUp()
        // This is the setUp() class method.
        // It is called before the first test method begins.
        // Set up any overall initial state here.
        plexy.token = ProcessInfo.processInfo.environment["plexToken"] ?? ""
    }
    
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
        
        plexy.Servers.getServers(token: plexy.token) { i in
            response = i
            gotResponse.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(response == nil)
        
    }

    func testGetPlaylists() {
        
        let gotResponse = expectation(description: "gresp")
        var response: PlaylistsResponse? = nil
        
        plexy.Playlists.getAll { i in
            response = i
            gotResponse.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        guard let r = response else {
            XCTFail("Response is nil")
            return
        }
        
        XCTAssertTrue(r.MediaContainer.size > 0)
        XCTAssertTrue(r.MediaContainer.Metadata.count > 0)

    }
    
    func testGetPlaylistItems() {
        
        let gotResponse = expectation(description: "gresp")
        var response: PlaylistItemsResponse? = nil
        
        plexy.Playlists.getItems(token: plexy.token, ratingKey: "10") { i in
            response = i
            gotResponse.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        guard let r = response else {
            XCTFail("Response is nil")
            return
        }
                
        XCTAssertTrue(r.MediaContainer.size > 0)
        XCTAssertTrue(r.MediaContainer.Metadata.count > 0)
    }
    
    func testSignIn() {
        
        let gotResponse = expectation(description: "Got Response")
        var response: SignInResponse? = nil
        
        plexy.Auth.getToken(username: "", password: "") { i in
            response = i
            gotResponse.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        guard let r = response else {
            XCTFail("Response is nil")
            return
        }
        
        XCTAssertFalse(r.user.authToken.isEmpty)
        
    }
    
    func testFileDownload() {
        let playlistId = "11"
        var documentsDir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
        
        let gotResponse = expectation(description: "gresp")
        var response: PlaylistItemsResponse? = nil
        
        plexy.Playlists.getItems(token: plexy.token, ratingKey: playlistId) { i in
            response = i
            gotResponse.fulfill()
        }
        
        wait(for: [gotResponse], timeout: 5)
        
        guard let r = response else {
            XCTFail("Response is nil")
            return;
        }
        
        guard let item = r.MediaContainer.Metadata.first(where: { i in
            i.Media.count > 0
        }) else {
            XCTFail("Metadata not found")
            return
        }
        
        guard let media = item.Media.first else {
            XCTFail("Media not found")
            return
        }
        
        guard let part = media.Part.first else {
            XCTFail("Part not found")
            return
        }
        
        var title = "Unknown"
        
        if let t = item.title {
            title = t
        }
        
        let saveDestination = documentsDir.appendingPathComponent(title).appendingPathExtension(part.container)
        
        print(saveDestination.absoluteString)

        let fileDownloaded = expectation(description: "fdown")

        item.Media.forEach { m in
            m.Part.forEach { p in
                p.download(token: plexy.token, to: saveDestination) { progress in
                    if(progress == 100) {
                        fileDownloaded.fulfill()
                    }
                }
            }
        }

        wait(for: [fileDownloaded], timeout: 10)
    }
    
    
    static var allTests = [
        ("testGetIdentity", testGetIdentity),
        ("testSignIn", testSignIn),
    ]
}
