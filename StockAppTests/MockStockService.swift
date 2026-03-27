//
//  MockStockService.swift
//  StockApp
//
//  Created by Rajni Bala on 26/03/26.
//

import Combine
import Foundation
@testable import StockApp

class MockStockService: StockServiceProtocol {
    
    var shouldFail = false
    
    func fetchStocks() -> AnyPublisher<[Stock], Error> {
        if shouldFail {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
        
        let stocks = [
            Stock(symbol: "AAPL", shortName: "Apple", regularMarketPrice: 150),
            Stock(symbol: "GOOG", shortName: "Google", regularMarketPrice: 2800)
        ]
        
        return Just(stocks)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func fetchStockDetail(symbol: String) -> AnyPublisher<Stock, Error> {
        if shouldFail {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
        
        let stock = Stock(symbol: symbol, shortName: "Mock", regularMarketPrice: 100)
        
        return Just(stock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
