//
//  APIClient.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/05/01.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    private init() {}
    
    private let baseURL = "http://localhost:3000"
    
    func fetchPosts() async throws -> [Post] {
        var data: Data
        var response: URLResponse
        
        guard let url = URL(string: "\(baseURL)/posts") else {
            throw APIError.invalidURL
        }
        
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw APIError.networkError(error)
        }
        
        if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }
        
        
        do {
            return try JSONDecoder().decode([Post].self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
        
    }
}
