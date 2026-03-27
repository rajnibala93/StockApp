//
//  StockRowView.swift
//  StockApp
//
//  Created by Rajni Bala on 24/03/26.
//

import SwiftUI

struct StockRowView: View {
    
    let stock: Stock
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(stock.shortName ?? "")
                .font(.headline)
            
            HStack {
                Text("\(stock.regularMarketPrice ?? 0)")
                Spacer()
                Text("\(stock.symbol)")
            }
        }
    }
}
