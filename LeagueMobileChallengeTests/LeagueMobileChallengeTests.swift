import XCTest
@testable import LeagueMobileChallenge

class LeagueMobileChallengeTests: XCTestCase {
    
    override func setUp() {}
    
    override func tearDown() {}
    
    func testGerUserToken() async throws {
        Current.urlSession = { request in
            let jsonResponse = TestData.apiKeyJSON
            let data = jsonResponse.data(using: .utf8)!
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, response)
        }
        
        let apiKey = try await APIController.shared.fetchUserToken()
        XCTAssert(apiKey == "5ECDDC3A21CE53428227A2125B7FCC71")
    }
    
    func testFetchPosts() async throws {
        Current.urlSession = { request in
            let jsonResponse = TestData.apiKeyJSON
            let data = jsonResponse.data(using: .utf8)!
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, response)
        }
        
        let apiKey = try await APIController.shared.fetchUserToken()
        XCTAssert(apiKey == "5ECDDC3A21CE53428227A2125B7FCC71")
        
        Current.urlSession = { request in
            let jsonResponse = TestData.postsJSON
            let data = jsonResponse.data(using: .utf8)!
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, response)
        }
        
        let posts = try await APIController.shared.fetchPosts()
        
        let userId = posts[0].userId
        let id = posts[0].id
        let title = posts[0].title
        let body = posts[0].body
        
        XCTAssert(userId == 1, "Decoding userId failed")
        XCTAssert(id == 1, "Decoding id failed")
        XCTAssert(title == "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", "Decoding title failed")
        XCTAssert(body == "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto", "Decoding body failed")
    }
    
    func testFetchPostsShouldFailWhenResponseIsNot200() async throws {
        Current.urlSession = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (Data(), response)
        }
        do {
            let _ = try await APIController.shared.fetchPosts()
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertTrue(error is APIError)
            XCTAssertEqual(error as? APIError, .invalidResponse)
        }
    }
    
    func testFetchUsersShouldFailWhenResponseIsNot200() async throws {
        Current.urlSession = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (Data(), response)
        }
        do {
            let _ = try await APIController.shared.fetchUsers()
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertTrue(error is APIError)
            XCTAssertEqual(error as? APIError, .invalidResponse)
        }
    }
    
    func testFetchUsers() async throws {
        Current.urlSession = { request in
            let jsonResponse = TestData.apiKeyJSON
            let data = jsonResponse.data(using: .utf8)!
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, response)
        }
        
        let apiKey = try await APIController.shared.fetchUserToken()
        XCTAssert(apiKey == "5ECDDC3A21CE53428227A2125B7FCC71")
        Current.urlSession = { request in
            let jsonResponse = TestData.usersJSON
            let data = jsonResponse.data(using: .utf8)!
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (data, response)
        }
        
        let users = try await APIController.shared.fetchUsers()
        
        XCTAssertEqual(users[0].id, 1, "Decoding user Id failed")
        XCTAssertEqual(users[0].avatar, "https://i.pravatar.cc/150?u=1", "Decoding avatar failed")
        XCTAssertEqual(users[0].name, "Leanne Graham", "Decoding name failed")
        XCTAssertEqual(users[0].username, "Bret", "Decoding username failed")
        XCTAssertEqual(users[0].email, "Sincere@april.biz", "Decoding email failed")
        
        XCTAssertEqual(users[0].address.street, "Kulas Light", "Decoding street failed")
        XCTAssertEqual(users[0].address.suite, "Apt. 556", "Decoding suite failed")
        XCTAssertEqual(users[0].address.city, "Gwenborough", "Decoding city failed")
        XCTAssertEqual(users[0].address.zipcode, "92998-3874", "Decoding zipcode failed")
        
        XCTAssertEqual(users[0].address.geo.lat, "-37.3159", "Decoding latitude failed")
        XCTAssertEqual(users[0].address.geo.lng, "81.1496", "Decoding longitude failed")
        
        XCTAssertEqual(users[0].phone, "1-770-736-8031 x56442", "Decoding phone failed")
        XCTAssertEqual(users[0].website, "hildegard.org", "Decoding website failed")
        
        XCTAssertEqual(users[0].company.name, "Romaguera-Crona", "Decoding company name failed")
        XCTAssertEqual(users[0].company.catchPhrase, "Multi-layered client-server neural-net", "Decoding catch phrase failed")
        XCTAssertEqual(users[0].company.bs, "harness real-time e-markets", "Decoding business strategy failed")
        
        XCTAssertEqual(users.count, 2, "Expected two users")
    }
}
