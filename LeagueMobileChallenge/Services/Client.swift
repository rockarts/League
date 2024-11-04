//
//  Client.swift
//  LeagueMobileChallenge
//
//  Created by Steven Rockarts on 2024-11-01.
//

import Foundation

/// Wrapper over URLSession requests. Allows for setting up a live connection or injecting a testable response.
struct Client  {
    var urlSession:  (URLRequest) async throws -> (Data, URLResponse) = URLSession.shared.data(for:)
    
    static let live = Client(urlSession: { request in
        try await URLSession.shared.data(for: request)
    })
}

var Current = Client.live
