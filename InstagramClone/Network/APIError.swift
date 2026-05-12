//
//  APIError.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/05/01.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case decodingFailed
    case serverError(statusCode: Int)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .decodingFailed:
            return "Decoding failed"
        case .serverError(statusCode: let code):
            return "Server error: \(code)"
        case .networkError(let underlyingError):
            return "Network error: \(underlyingError.localizedDescription)"
        }
    }
}

