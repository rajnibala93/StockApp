//
//  APIClient.swift
//  StockApp
//
//  Created by Rajni Bala on 24/03/26.
//

import Foundation
import Combine

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error>
}

class APIClient: APIClientProtocol {
    
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        
        guard let url = URL(string: endpoint.url.absoluteString) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.headers
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                guard 200...299 ~= response.statusCode else {
                    throw NetworkError.invalidStatusCode(response.statusCode)
                }
                
                guard !output.data.isEmpty else {
                    throw NetworkError.noData
                }
                
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                
                if let networkError = error as? NetworkError {
                    return networkError
                } else if error is DecodingError {
                    return .decodingError
                } else {
                    return .unknown(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
