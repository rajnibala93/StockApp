//
//  StockListViewModel.swift
//  StockApp
//
//  Created by Rajni Bala on 24/03/26.
//

import Combine
import Foundation

class StockListViewModel: ObservableObject {
    
    @Published var stocks: [Stock] = []
    @Published var filteredStocks: [Stock] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let service: StockServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: StockServiceProtocol) {
        self.service = service
        bindSearch()
        startAutoRefresh()
    }
    
    func fetchStocks() {
        isLoading = true
        errorMessage = nil
        
        service.fetchStocks()
                .sink(receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] stocks in
                    self?.stocks = stocks
                })
                .store(in: &cancellables)
    }
    
    private func bindSearch() {
        $searchText
            .combineLatest($stocks)
            .map { search, stocks in
                guard !search.isEmpty else { return stocks }
                
                return stocks.filter {
                    $0.shortName?.lowercased().contains(search.lowercased()) ?? false
                }
            }
            .assign(to: &$filteredStocks)
    }
    
    private func startAutoRefresh() {
        Timer.publish(every: 8, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchStocks()
            }
            .store(in: &cancellables)
    }
}
