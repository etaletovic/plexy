import XCTest
import Foundation
@testable import Plexy

final class PlexyTests: XCTestCase {

    override class func setUp() { // 1.
        super.setUp()
        // This is the setUp() class method.
        // It is called before the first test method begins.
        // Set up any overall initial state here.
        Plexy.token = ProcessInfo.processInfo.environment["plexToken"] ?? ""
    }

    func testGetIdentity() {
        let gotResponse = expectation(description: "gresp")
        var response: IdentityResponse?

        Plexy.Identity.getIdentity { identity in
            response = identity
            gotResponse.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(response?.mediaContainer)

    }

    func testGetServers() {

        let gotResponse = expectation(description: "gresp")
        var response: ServersResponse?

        Plexy.Servers.getServers { servers in
            response = servers
            gotResponse.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(response == nil)

    }

    func testGetPlaylists() {

        let gotResponse = expectation(description: "gresp")
        var response: PlaylistsResponse?

        Plexy.Playlists.getAll { playlists in
            response = playlists
            gotResponse.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        guard let res = response else {
            XCTFail("Response is nil")
            return
        }

        XCTAssertTrue(res.mediaContainer.size > 0)
        XCTAssertTrue(res.mediaContainer.metadata.count > 0)

    }

    func testGetPlaylistItems() {

        let gotResponse = expectation(description: "gresp")
        var response: PlaylistItemsResponse?

        Plexy.Playlists.getItems(ratingKey: "10") { items in
            response = items
            gotResponse.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        guard let res = response else {
            XCTFail("Response is nil")
            return
        }

        XCTAssertTrue(res.mediaContainer.size > 0)
        XCTAssertTrue(res.mediaContainer.metadata.count > 0)
    }

    func testSignIn() {

        let gotResponse = expectation(description: "Got Response")
        var response: SignInResponse?

        Plexy.Auth.getToken(username: "", password: "") { token in
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

    func testFileDownload() {
        let playlistId = "11"
        let documentsDir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]

        let gotResponse = expectation(description: "gresp")
        var response: PlaylistItemsResponse?

        Plexy.Playlists.getItems(ratingKey: playlistId) { items in
            response = items
            gotResponse.fulfill()
        }

        wait(for: [gotResponse], timeout: 5)

        guard let res = response else {
            XCTFail("Response is nil")
            return
        }

        guard let item = res.mediaContainer.metadata.first(where: { meta in
            meta.media.count > 0
        }) else {
            XCTFail("Metadata not found")
            return
        }

        guard let media = item.media.first else {
            XCTFail("Media not found")
            return
        }

        guard let part = media.part.first else {
            XCTFail("Part not found")
            return
        }

        let title = item.title ?? "Unknown"

        let saveDestination = documentsDir.appendingPathComponent(title).appendingPathExtension(part.container)

        print(saveDestination.absoluteString)

        let fileDownloaded = expectation(description: "fdown")

        item.media.forEach { media in
            media.part.forEach { part in
                part.download(saveTo: saveDestination) { progress in
                    if progress == 100 {
                        fileDownloaded.fulfill()
                    }
                }
            }
        }

        wait(for: [fileDownloaded], timeout: 10)
    }

    static var allTests = [
        ("testGetIdentity", testGetIdentity),
        ("testSignIn", testSignIn)
    ]
}
