//
//  StockService.swift
//  StockApp
//
//  Created by Rajni Bala on 24/03/26.
//

import Combine

protocol StockServiceProtocol {
    func fetchStocks() -> AnyPublisher<[Stock], Error>
    func fetchStockDetail(symbol: String) -> AnyPublisher<Stock, Error>
}

class StockService: StockServiceProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchStocks() -> AnyPublisher<[Stock], Error> {
        let endpoint = Endpoint(path: "market/v2/get-summary")
        
        return apiClient.request(endpoint)
            .map { (response: StockListResponse) in response.stocks }
            .eraseToAnyPublisher()
    }
    
    //Not getting any response for endpoint stock/v2/get-summary?symbol=, so unable to parse it
    func fetchStockDetail(symbol: String) -> AnyPublisher<Stock, Error> {
        let endpoint = Endpoint(path: "stock/v2/get-summary?symbol=\(symbol)")
        return apiClient.request(endpoint)
        
    }
}
