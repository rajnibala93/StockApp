//
//  StockListView.swift
//  StockApp
//
//  Created by Rajni Bala on 24/03/26.
//

import SwiftUI
import Swinject

struct StockListView: View {
    
    @StateObject var viewModel: StockListViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading && viewModel.filteredStocks.isEmpty {
                    ProgressView("Loading stocks...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                    
                    Button("Retry") {
                        viewModel.fetchStocks()
                    }
                } else {
                    List(viewModel.filteredStocks) { stock in
                        NavigationLink(
                            destination: StockDetailView(
                                symbol: stock.symbol,
                                viewModel: DIContainer.shared.resolve(StockDetailViewModel.self)!
                            )
                        ) {
                            StockRowView(stock: stock)
                        }
                    }
                }
            }
            .navigationTitle("Stocks")
            .searchable(text: $viewModel.searchText)
            .onAppear {
                viewModel.fetchStocks()
            }
        }
    }
}
