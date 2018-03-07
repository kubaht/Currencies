//
//  CalculateExchangeRateInteractorTests.swift
//  Currencies
//
//  Created by Jakub Hutny on 14.12.2016.
//  Copyright (c) 2016 Jakub Hutny. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

@testable import Currencies
import XCTest

class CalculateExchangeRateInteractorTests: XCTestCase
{
    // MARK: - Subject under test
  
    var sut: CalculateExchangeRateInteractor!
  
    // MARK: - Test lifecycle
  
    override func setUp()
    {
        super.setUp()
        setupCalculateExchangeRateInteractor()
    }
  
    override func tearDown()
    {
        super.tearDown()
    }
  
    // MARK: - Test setup
  
    func setupCalculateExchangeRateInteractor()
    {
        sut = CalculateExchangeRateInteractor()
    }
  
    // MARK: - Test doubles
    
    class CalculateExchangeRateInteractorOutputSpy: CalculateExchangeRateInteractorOutput {
        var presentFetchedCurrenciesCalled = false
        var presentGetInputNameLabelCalled = false
        var presentGetOutputNameLabelCalled = false
        var presentGetResultLabelCalled = false
        var presentFetchedQuotationDateCalled = false
        
        var response: CalculateExchangeRate.FetchCurrencies.Response!
        
        func presentFetchedCurrencies(response: CalculateExchangeRate.FetchCurrencies.Response) {
            self.response = response
            presentFetchedCurrenciesCalled = true
        }
        
        func presentGetInputLabelName(response: CalculateExchangeRate.InputLabel.Response) {
            presentGetInputNameLabelCalled = true
        }
        
        func presentGetOutputLabelName(response: CalculateExchangeRate.OutputLabel.Response) {
            presentGetOutputNameLabelCalled = true
        }
        
        func presentResultLabel(response: CalculateExchangeRate.ResultLabel.Response) {
            presentGetResultLabelCalled = true
        }
        
    }
    
    class CurrenciesWorkerSpy: CurrenciesWorker {
        var fetchCurrenciesCalled = false
        var fetchQuotationDateCalled = false
        var getCurrencyCalled = false
        
        override func fetchCurrencies(completionHandler: @escaping (_ currency: [Currency], _ date: String) -> Void) {
            fetchCurrenciesCalled = true
            completionHandler([Currency(name: "EUR", value: 4.00), Currency(name: "PLN", value: 3.50)], "2016-10-24")
        }
        
        override func getCurrency(with name: String) -> Currency {
            getCurrencyCalled = true
            
            return Currency(name: "EUR", value: 3.5)
        }
    }
    
    class CalculateExchangeRateWorkerSpy: CalculateExchangeRateWorker {
        var calculateResultCalled = false
        
        override func calculateResult(isOnStart: Bool, inputRate: Double, outputRate: Double, amount: Double) -> Double {
            if !isOnStart {
                calculateResultCalled = true
            }
            
            return 3.5
        }
    }
  
  // MARK: - Tests
  
    func testShouldAskCurrenciesWorkerToFetchOrdersAndPresenterToFormatResults() {
        // Given
        let calculateExchangeRateInteractorOutputSpy = CalculateExchangeRateInteractorOutputSpy()
        sut.output = calculateExchangeRateInteractorOutputSpy
        let currenciesWorkerSpy = CurrenciesWorkerSpy(currenciesStore: CurrenciesAPI())
        sut.currenciesWorker = currenciesWorkerSpy
        let expectedCurrencies = [Currency(name: "EUR", value: 4.00), Currency(name: "PLN", value: 3.50)]
        
        // When
        let request = CalculateExchangeRate.FetchCurrencies.Request()
        sut.fetchCurrencies(request: request)
        
        // Then
        XCTAssert(currenciesWorkerSpy.fetchCurrenciesCalled, "fetchCurrencies() should call CurrenciesWorker to fetch the currencies.")
        XCTAssert(calculateExchangeRateInteractorOutputSpy.presentFetchedCurrenciesCalled, "fetchCurrencies() should ask Present to format the fetched currencies.")
        CurrencyHelper.compareTwoCurrencies(firstCurrencies: calculateExchangeRateInteractorOutputSpy.response.currencies, secondCurrencies: expectedCurrencies)
    }
    
    func testShouldAskPresenterToFormatInputName() {
        // Given
        let calculateExchangeRateInteractorOutputSpy = CalculateExchangeRateInteractorOutputSpy()
        sut.output = calculateExchangeRateInteractorOutputSpy
        
        // When
        let request = CalculateExchangeRate.InputLabel.Request()
        sut.getInputLabelName(request: request)
        
        // Then
        XCTAssert(calculateExchangeRateInteractorOutputSpy.presentGetInputNameLabelCalled, "getInputLabelName() should ask Presenter to format the input label name.")
    }
    
    func testShouldAskPresenterToFormatOutputName() {
        // Given
        let calculateExchangeRateInteractorOutputSpy = CalculateExchangeRateInteractorOutputSpy()
        sut.output = calculateExchangeRateInteractorOutputSpy
        
        // When
        let request = CalculateExchangeRate.OutputLabel.Request()
        sut.getOutputLabelName(request: request)
        
        // Then
        XCTAssert(calculateExchangeRateInteractorOutputSpy.presentGetOutputNameLabelCalled, "getOutputLabelName() should ask Presenter to format the output label name.")
    }
    
    func testShouldAskPresenterToFormatResultOnLoad() {
        // Given
        let calculateExchangeRateInteractorOutputSpy = CalculateExchangeRateInteractorOutputSpy()
        sut.output = calculateExchangeRateInteractorOutputSpy
        
        // When
        let request = CalculateExchangeRate.ResultLabel.Request(isOnStart: true)
        sut.getResultLabel(request: request)
        
        // Then
        XCTAssert(calculateExchangeRateInteractorOutputSpy.presentGetResultLabelCalled, "getResultLabel() should ask Presenter to format the result label on load.")
    }
    
    func testShouldAskWorkerToGetCurrencyAndAskWorkerToCalculateResultAndPresenterToFormatResult() {
        // Given
        let calculateExchangeRateInteractorOutputSpy = CalculateExchangeRateInteractorOutputSpy()
        sut.output = calculateExchangeRateInteractorOutputSpy
        let currenciesWorkerSpy = CurrenciesWorkerSpy(currenciesStore: CurrenciesAPI())
        sut.currenciesWorker = currenciesWorkerSpy
        let calculateExchangeRateWorkerSpy = CalculateExchangeRateWorkerSpy()
        sut.calculateExchangeRateWorker = calculateExchangeRateWorkerSpy
        let amount = "5.00"
        let inputCurrency = "EUR"
        let outputCurrency = "PLN"
        
        // When
        let request = CalculateExchangeRate.ResultLabel.Request(amount: amount, inputCurrency: inputCurrency, outputCurrency: outputCurrency)
        sut.calculateExchangeResult(request: request)
        
        // Then
        XCTAssert(currenciesWorkerSpy.getCurrencyCalled, "calculateExchangeResult() should call CurrenciesWorker to get currency object.")
        XCTAssert(calculateExchangeRateWorkerSpy.calculateResultCalled, "calculateExchangeResult() should call CalculateExchangeRateWorker to calculate result.")
        XCTAssert(calculateExchangeRateInteractorOutputSpy.presentGetResultLabelCalled, "calculateExchangeResult() should ask Presenter to format the result label.")
    }
}