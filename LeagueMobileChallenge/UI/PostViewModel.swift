//
//  PostViewModel.swift
//  LeagueMobileChallenge
//
//  Created by Steven Rockarts on 2024-11-03.
//

import Foundation
import UIKit

struct PostViewModel {
    func getPosts() async throws -> [UserPosts] {
        do {
            let _ = try await CurrentAPI.fetchUserToken("", "")
            let users = try await CurrentAPI.fetchUsers()
            let posts: [Post] = try await CurrentAPI.fetchPosts()
            
            let userPosts = posts.compactMap { (post: Post) -> UserPosts? in
                guard let user = users.first(where: { $0.id == post.userId }) else {
                    return nil
                }
                
                return UserPosts(
                    postId: post.id,
                    userId: post.userId,
                    title: post.title,
                    body: post.body,
                    username: user.name,
                    avatarImage: user.avatar
                )
            }
            
            return userPosts
        } catch {
            throw error
        }
    }
}

struct UserPosts {
    let postId: Int
    let userId: Int
    let title: String
    let body: String
    let username: String
    let avatarImage: String?
}
