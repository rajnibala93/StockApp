//
//  Endpoint.swift
//  StockApp
//
//  Created by Rajni Bala on 25/03/26.
//

import Foundation

struct Endpoint {
    private let apiKey = "YOUR_API_KEY"
    //Note: yh-finance.p.rapidapi.com - the given host is broken, so i have integrated by using the lastest one
    private let host = "apidojo-yahoo-finance-v1.p.rapidapi.com"
    
    let path: String
    
    var url: URL {
        return URL(string: "https://\(host)/\(path)")!
    }
    
    var headers: [String: String] {
        return [
            "X-RapidAPI-Key": apiKey,
            "X-RapidAPI-Host": host
        ]
    }
}
