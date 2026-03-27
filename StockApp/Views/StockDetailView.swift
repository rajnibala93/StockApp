//
//  StockDetailView.swift
//  StockApp
//
//  Created by Rajni Bala on 25/03/26.
//

import SwiftUI

struct StockDetailView: View {
    
    let symbol: String
    @StateObject var viewModel: StockDetailViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading details...")
                
            } else if let error = viewModel.errorMessage {
                VStack {
                    Text("Error: \(error)")
                    
                    Button("Retry") {
                        viewModel.fetch(symbol: symbol)
                    }
                }
                
            } else if let stock = viewModel.stock {
                VStack(spacing: 12) {
                    Text(stock.shortName ?? "")
                        .font(.largeTitle)
                    
                    Text("Price: \(stock.regularMarketPrice ?? 0)")
                    Text("Symbol: \(stock.symbol)")
                }
                
            } else {
                Text("No Data")
            }
        }
        .onAppear {
            viewModel.fetch(symbol: symbol)
        }
    }
}
