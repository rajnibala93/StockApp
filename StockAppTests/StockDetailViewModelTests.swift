//
//  StockDetailViewModelTests.swift
//  StockApp
//
//  Created by Rajni Bala on 26/03/26.
//

import XCTest
import Combine
@testable import StockApp

final class StockDetailViewModelTests: XCTestCase {
    
    var viewModel: StockDetailViewModel!
    var mockService: MockStockService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        mockService = MockStockService()
        viewModel = StockDetailViewModel(service: mockService)
        cancellables = []
    }
    
    //1 Test - fetch detail success
    func testFetchDetail_success() {
        let expectation = XCTestExpectation(description: "Fetch detail success")
        
        viewModel.$stock
            .dropFirst()
            .sink { stock in
                XCTAssertNotNil(stock)
                XCTAssertEqual(stock?.symbol, "AAPL")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetch(symbol: "AAPL")
        
        wait(for: [expectation], timeout: 2)
    }
    
    //Test - fetch detail failure
    func testFetchDetail_failure() {
        mockService.shouldFail = true
        
        let expectation = XCTestExpectation(description: "Failure received")
        
        viewModel.$errorMessage
            .sink { error in
                if error != nil {
                    XCTAssertTrue(true)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetch(symbol: "AAPL")
        
        wait(for: [expectation], timeout: 2)
    }
}
