//
//  Endpoint.swift
//  StockApp
//
//  Created by Rajni Bala on 25/03/26.
//

import Foundation

struct Endpoint {
    private let apiKey = "3bb44fee1dmshe55c9b543853befp1711afjsn0e91e5c5790d"
    //Note: yh-finance.p.rapidapi.com - the given host is broken, so i have integrated by using the lastest one
    private let host = "apidojo-yahoo-finance-v1.p.rapidapi.com"
   // private let host = "yh-finance.p.rapidapi.com"
    
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
