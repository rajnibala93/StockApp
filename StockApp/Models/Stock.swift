//
//  Stock.swift
//  StockApp
//
//  Created by Rajni Bala on 24/03/26.
//

import Foundation

struct Stock: Identifiable, Decodable {
    var id = UUID()
    let symbol: String
    let shortName: String?
    let regularMarketPrice: Double?
}
