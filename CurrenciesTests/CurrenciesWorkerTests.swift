//
//  CurrenciesWorkerTests.swift
//  Currencies
//
//  Created by Jakub Hutny on 16.12.2016.
//  Copyright © 2016 Jakub Hutny. All rights reserved.
//

@testable import Currencies
import XCTest

class CurrenciesWorkerTest: XCTestCase {
    // MARK: Subject under test
    
    var sut: CurrenciesWorker!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupCurrenciesWorker()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupCurrenciesWorker() {
        sut = CurrenciesWorker(currenciesStore: CurrenciesAPISpy() as CurrenciesProtocol)
    }
    
    // MARK: Test doubles
    
    class CurrenciesAPISpy: CurrenciesAPI {
        var fetchCurrenciesCalled = false
        var fetchQuotationDateCalled = false
        
        override func fetchCurrencies(completionHandler: @escaping ([Currency], String) -> Void) {
            fetchCurrenciesCalled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completionHandler([Currency(name: "EUR", value: 3.5), Currency(name: "USD", value: 4.0)], "2016-10-24")
            }
        }
        
        override func getCurrency(with name: String) -> Currency {
            self.currencies = [Currency(name: "EUR", value: 3.5), Currency(name: "USD", value: 4.0)]
            
            return super.getCurrency(with: name)
        }
    }
    
    // MARK: Tests
    
    func testFetchCurrenciesShouldReturnListOfCurrencies() {
        // Given
        let currenciesMemoryStorageSpy = CurrenciesAPISpy()
        
        // When
        let fetchExpectation = expectation(description: "Wait for fetched currencies result.")
        currenciesMemoryStorageSpy.fetchCurrencies { (_: [Currency], _: String) -> Void in
            fetchExpectation.fulfill()
        }
        
        // Then
        XCTAssert(currenciesMemoryStorageSpy.fetchCurrenciesCalled, "Calling fetchCurrencies() should ask the data store for a list of currencies.")
        waitForExpectations(timeout: 1.1) { XCWaitCompletionHandler in
            XCTAssert(true, "Calling fetchCurrencies() should result in the completion handler being called with the fetch currencies results.")
        }
    }
    
    func testShouldReturnFoundCurrency() {
        // Given
        let currenciesMemoryStorageSpy = CurrenciesAPISpy()
        let name = "EUR"
        
        // When
        let currency = currenciesMemoryStorageSpy.getCurrency(with: name)
        
        // Then
        XCTAssertEqual(currency.name, name)
        XCTAssertEqual(currency.value, 3.5)
    }
}
