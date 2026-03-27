//
//  StockAppApp.swift
//  StockApp
//
//  Created by Rajni Bala on 24/03/26.
//

import SwiftUI
import Swinject

@main
struct StockAppApp: App {
    
    init() {
        DIContainer.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            let vm = DIContainer.shared.resolve(StockListViewModel.self)!
            StockListView(viewModel: vm)
        }
    }
}
