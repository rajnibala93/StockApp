//
//  DIContainer.swift
//  StockApp
//
//  Created by Rajni Bala on 24/03/26.
//

import Swinject

class DIContainer {
    
    static let shared = Container()
    
    static func setup() {
        let container = shared
        
        container.register(APIClientProtocol.self) { _ in
            APIClient()
        }
        
        container.register(StockServiceProtocol.self) { r in
            StockService(apiClient: r.resolve(APIClientProtocol.self)!)
        }
        
        container.register(StockListViewModel.self) { r in
            StockListViewModel(service: r.resolve(StockServiceProtocol.self)!)
        }
        
        container.register(StockDetailViewModel.self) { r in
            StockDetailViewModel(service: r.resolve(StockServiceProtocol.self)!)
        }
    }
}
