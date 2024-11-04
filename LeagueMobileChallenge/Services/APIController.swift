import Foundation

enum APIError: Error, Equatable {
    case invalidURL
    case noToken
    case invalidResponse
    case decodingError
}

actor APIController {
    static let user = "user"
    static let password = "password"
    
    static let domain = "https://engineering.league.dev/challenge/api/"
    let loginAPI = domain + "login"
    let postAPI = domain + "posts"
    let userAPI = domain + "users"
    
    static let shared = APIController()
    
    private var userToken: String?
    
    func fetchUserToken(userName: String = "", password: String = "") async throws -> String {
        guard let url = URL(string: loginAPI) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let authData = "\(userName):\(password)".data(using: .utf8) {
            let base64Auth = authData.base64EncodedString()
            request.setValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await Current.urlSession(request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        guard let dict = try? JSONSerialization.jsonObject(with: data) as? [String: String],
              let apiKey = dict["api_key"] else {
            throw APIError.decodingError
        }
        
        userToken = apiKey
        return apiKey
    }
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: postAPI) else {
            throw APIError.invalidURL
        }
        if let data = try await request(url: url) {
            
            let decoder = JSONDecoder()
            return try decoder.decode([Post].self, from: data)
        } else {
            return []
        }
    }
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: userAPI) else {
            throw APIError.invalidURL
        }
        if let data = try await request(url: url) {
            let decoder = JSONDecoder()
            return try decoder.decode([User].self, from: data)
        } else {
            return []
        }
    }
    
    private func request(url: URL) async throws -> Data? {
        guard let userToken = userToken else {
            debugPrint("No user token set")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(userToken, forHTTPHeaderField: "x-access-token")
        
        let (data, response) = try await Current.urlSession(request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        return data
    }
}
