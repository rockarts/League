//
//  APIControllerClient.swift
//  LeagueMobileChallenge
//
//  Created by Steven Rockarts on 2024-11-03.
//
import Foundation

struct APIControllerClient {
    var fetchUserToken: (String, String) async throws -> String = { userName, password in
        try await APIController.shared.fetchUserToken(userName: userName, password: password)
    }
    
    var fetchPosts: () async throws -> [Post] = {
        return try await APIController.shared.fetchPosts()
    }
    
    var fetchUsers: () async throws -> [User] = {
        try await APIController.shared.fetchUsers()
    }
    
    static let live = APIControllerClient(
        fetchUserToken: { userName, password in
            try await APIController.shared.fetchUserToken(userName: userName, password: password)
        },
        fetchPosts: {
            try await APIController.shared.fetchPosts()
        },
        fetchUsers: {
            try await APIController.shared.fetchUsers()
        }
    )
}

var CurrentAPI = APIControllerClient.live
