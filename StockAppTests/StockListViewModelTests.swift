//
//  StockListViewModelTests.swift
//  StockApp
//
//  Created by Rajni Bala on 26/03/26.
//

import XCTest
import Combine
@testable import StockApp

final class StockListViewModelTests: XCTestCase {
    
    var viewModel: StockListViewModel!
    var mockService: MockStockService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        mockService = MockStockService()
        viewModel = StockListViewModel(service: mockService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
    }
    
    //1 - Test loading
    func testFetchStocks_loadingState() {
        viewModel.fetchStocks()
        
        XCTAssertTrue(viewModel.isLoading == false)
    }
    
    //2 - Test fetch stocks - success
    func testFetchStocks_success() {
        let expectation = XCTestExpectation(description: "Fetch stocks success")
        
        viewModel.$stocks
            .dropFirst()
            .sink { stocks in
                XCTAssertEqual(stocks.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchStocks()
        wait(for: [expectation], timeout: 2)
    }
    
    //3 - Test fetch socks - failure
    func testFetchDetail_failure() {
        mockService.shouldFail = true
        
        let expectation = XCTestExpectation(description: "Fetch stocks failure")
        
        viewModel.$errorMessage
            .sink { error in
                if error != nil {
                    XCTAssertTrue(true)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchStocks()
        
        wait(for: [expectation], timeout: 2)
    }
        
    //4 - Test search stock ny name
    func testSearchFiltering() {
        viewModel.stocks = [
            Stock(symbol: "AAPL", shortName: "Apple", regularMarketPrice: 150),
            Stock(symbol: "GOOG", shortName: "Google", regularMarketPrice: 2000)
        ]
        
        viewModel.searchText = "app"
        
        XCTAssertEqual(viewModel.filteredStocks.count, 1)
        XCTAssertEqual(viewModel.filteredStocks.first?.symbol, "AAPL")
    }
    
}
