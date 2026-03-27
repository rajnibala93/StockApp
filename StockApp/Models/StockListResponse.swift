//
//  StockListResponse.swift
//  StockApp
//
//  Created by Rajni Bala on 24/03/26.
//

import Foundation

struct StockListResponse: Decodable {
    let marketSummaryAndSparkResponse: MarketSummaryContainer
    
    var stocks: [Stock] {
        marketSummaryAndSparkResponse.result.map {
            Stock(
                symbol: $0.symbol,
                shortName: $0.shortName,
                regularMarketPrice: $0.regularMarketPrice?.raw,
            )
        }
    }
}

struct MarketSummaryContainer: Decodable {
    let result: [MarketStock]
}

struct MarketStock: Decodable {
    let symbol: String
    let shortName: String?
    let regularMarketPrice: Price?
}

struct Price: Decodable {
    let raw: Double
}
