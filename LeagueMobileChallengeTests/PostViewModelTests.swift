//
//  PostViewModelTests.swift
//  LeagueMobileChallengeTests
//
//  Created by Steven Rockarts on 2024-11-04.
//

import XCTest
@testable import LeagueMobileChallenge

final class PostViewModelTests: XCTestCase {
    
    func testShouldBuildUserPostsFromPostsAndUsers() async throws {
        CurrentAPI.fetchUserToken = { username, password in
            return "test"
        }
        CurrentAPI.fetchPosts = {
            return TestData.posts
        }
        CurrentAPI.fetchUsers = {
            return TestData.users
        }
        
        let vm = PostViewModel()
        let userPosts = try await vm.getPosts()
        
        XCTAssert(userPosts.count == 5)
        
        for (index, post) in userPosts.enumerated() {
            XCTAssertEqual(post.postId, TestData.userPosts[index].postId)
            XCTAssertEqual(post.userId, TestData.userPosts[index].userId)
            XCTAssertEqual(post.title, TestData.userPosts[index].title)
            XCTAssertEqual(post.body, TestData.userPosts[index].body)
            XCTAssertEqual(post.username, TestData.userPosts[index].username)
            XCTAssertEqual(post.avatarImage, TestData.userPosts[index].avatarImage)
        }
    }
    
    func testShouldIgnorePostsThatDontHaveAValidUserId() async throws {
        CurrentAPI.fetchUserToken = { username, password in
            return "test"
        }
        CurrentAPI.fetchPosts = {
            var posts = TestData.posts
            posts.append(Post(userId: 99, id: 15, title: "Invalid", body: "Invalid"))
            return posts
        }
        CurrentAPI.fetchUsers = {
            return TestData.users
        }
        
        let vm = PostViewModel()
        let userPosts = try await vm.getPosts()
        
        XCTAssert(userPosts.count == 5)
    }
    
    func testShouldThrowWhenFetchUsersFails() async {
        CurrentAPI.fetchUserToken = { username, password in
            return "test"
        }
        CurrentAPI.fetchUsers = {
            throw APIError.invalidResponse
        }
        
        let vm = PostViewModel()
        
        do {
            _ = try await vm.getPosts()
            XCTFail("Expected getPosts to throw an error")
        } catch {
            XCTAssertTrue(error is APIError)
            XCTAssertEqual(error as? APIError, .invalidResponse)
        }
    }
    
    func testShouldThrowWhenFetchPostFails() async {
        CurrentAPI.fetchUserToken = { username, password in
            return "test"
        }
        CurrentAPI.fetchUsers = {
            return TestData.users
        }
        CurrentAPI.fetchPosts = {
            throw APIError.decodingError
        }
        
        let vm = PostViewModel()
        
        do {
            _ = try await vm.getPosts()
            XCTFail("Expected getPosts to throw an error")
        } catch {
            XCTAssertTrue(error is APIError)
            XCTAssertEqual(error as? APIError, .decodingError)
        }
    }
    
    func testShouldThrowWhenFetchPostsFails() async {
        CurrentAPI.fetchUserToken = { username, password in
            throw APIError.invalidResponse
        }
        
        let vm = PostViewModel()
        
        do {
            _ = try await vm.getPosts()
            XCTFail("Expected getPosts to throw an error")
        } catch {
            XCTAssertTrue(error is APIError)
            XCTAssertEqual(error as? APIError, .invalidResponse)
        }
    }
}
