//
//  StockDetailViewModel.swift
//  StockApp
//
//  Created by Rajni Bala on 25/03/26.
//

import Combine
import Foundation

class StockDetailViewModel: ObservableObject {
    
    @Published var stock: Stock?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let service: StockServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: StockServiceProtocol) {
        self.service = service
    }
    func fetch(symbol: String) {
        isLoading = true
        errorMessage = nil
        
        service.fetchStockDetail(symbol: symbol)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] stock in
                self?.stock = stock
            })
            .store(in: &cancellables)
    }
}
