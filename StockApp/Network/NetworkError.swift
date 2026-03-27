//
//  NetworkError.swift
//  StockApp
//
//  Created by Rajni Bala on 26/03/26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case noData
    case decodingError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .invalidStatusCode(let code):
            return "Server error: \(code)"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode response"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
