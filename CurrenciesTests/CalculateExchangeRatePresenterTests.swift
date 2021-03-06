//
//  CalculateExchangeRatePresenterTests.swift
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

class CalculateExchangeRatePresenterTests: XCTestCase
{
    // MARK: - Subject under test
  
    var sut: CalculateExchangeRatePresenter!
  
    // MARK: - Test lifecycle
  
    override func setUp()
    {
        super.setUp()
        setupCalculateExchangeRatePresenter()
    }
  
    override func tearDown()
    {
        super.tearDown()
    }
  
    // MARK: - Test setup
    
    func setupCalculateExchangeRatePresenter()
    {
        sut = CalculateExchangeRatePresenter()
    }
  
  // MARK: - Test doubles
    class CalculateExchangeRatePresenterOutputSpy: CalculateExchangeRatePresenterOutput {
        // MARK: Method call expectations
        var displayFetchedCurrenciesCalled = false
        var displayInputLabelNameCalled = false
        var displayOutputLabelNameCalled = false
        var displayResultLabelCalled = false
        var displayQuotationDateCalled = false
        
        // MARK: Argument expectations
        var calculateExchangeRate_fetchCurrencies_viewModel: CalculateExchangeRate.FetchCurrencies.ViewModel!
        var calculateExchangeRate_inputLabel_viewModel: CalculateExchangeRate.InputLabel.ViewModel!
        var calculateExchangeRate_outputLabel_viewModel: CalculateExchangeRate.OutputLabel.ViewModel!
        var calculateExchangeRate_resultLabel_viewModel: CalculateExchangeRate.ResultLabel.ViewModel!
 
        // MARK: Spied methods
        func displayFetchedCurrencies(viewModel: CalculateExchangeRate.FetchCurrencies.ViewModel) {
            displayFetchedCurrenciesCalled = true
            calculateExchangeRate_fetchCurrencies_viewModel = viewModel
        }
        
        func displayInputLabelName(viewModel: CalculateExchangeRate.InputLabel.ViewModel) {
            displayInputLabelNameCalled = true
            calculateExchangeRate_inputLabel_viewModel = viewModel
        }
        
        func displayOutputLabelName(viewModel: CalculateExchangeRate.OutputLabel.ViewModel) {
            displayOutputLabelNameCalled = true
            calculateExchangeRate_outputLabel_viewModel = viewModel
        }
        
        func displayResultLabel(viewModel: CalculateExchangeRate.ResultLabel.ViewModel) {
            displayResultLabelCalled = true
            calculateExchangeRate_resultLabel_viewModel = viewModel
        }
    }
    
  // MARK: - Tests
  
    func testPresentFetchedCurrenciesShouldFormatFetchedCurrenciesForDisplay()
    {
        // Given
        let calculateExchangeRatePresenterOutputSpy = CalculateExchangeRatePresenterOutputSpy()
        sut.output = calculateExchangeRatePresenterOutputSpy
        let currencies = [Currency(name: "PLN", value: 3.54)]
        let quotationDate = "2016-10-24"
        let response = CalculateExchangeRate.FetchCurrencies.Response(currencies: currencies, date: quotationDate)
    
        // When
        sut.presentFetchedCurrencies(response: response)
    
        // Then
        XCTAssert(calculateExchangeRatePresenterOutputSpy.displayFetchedCurrenciesCalled, "Presenting fetched currencies should ask ViewController to display them.")
         XCTAssertEqual(calculateExchangeRatePresenterOutputSpy.calculateExchangeRate_fetchCurrencies_viewModel.date, "Quotation date: October 24, 2016", "Presenting quotation date should format date in proper format.")
    }
    
    func testPresentInputLabelNameShouldFormatGotNameForDisplay() {
        // Given
        let calculateExchangePresenterOutputSpy = CalculateExchangeRatePresenterOutputSpy()
        sut.output = calculateExchangePresenterOutputSpy
        let labelName = "Input"
        let response = CalculateExchangeRate.InputLabel.Response(name: labelName)
        
        // When
        sut.presentGetInputLabelName(response: response)
        
        // Then
        XCTAssert(calculateExchangePresenterOutputSpy.displayInputLabelNameCalled, "Presenting input label name should ask ViewController to display it.")
    }
    
    func testPresentOutputLabelNameShouldFormatGotNameForDisplay() {
        // Given
        let calculateExchangePresenterOutputSpy = CalculateExchangeRatePresenterOutputSpy()
        sut.output = calculateExchangePresenterOutputSpy
        let labelName = "Output"
        let response = CalculateExchangeRate.OutputLabel.Response(name: labelName)
        
        // When
        sut.presentGetOutputLabelName(response: response)
        
        // Then
        XCTAssert(calculateExchangePresenterOutputSpy.displayOutputLabelNameCalled, "Presenting output label name should ask ViewController to display it.")
    }
    
    func testPresentResultLabelShouldFormatGotResultForDisplay() {
        // Given
        let calculateExchangePresenterOutputSpy = CalculateExchangeRatePresenterOutputSpy()
        sut.output = calculateExchangePresenterOutputSpy
        let result = 5.00
        let response = CalculateExchangeRate.ResultLabel.Response(result: result)
        
        // When
        sut.presentResultLabel(response: response)
        
        // Then
        XCTAssert(calculateExchangePresenterOutputSpy.displayResultLabelCalled, "Presenting result label should ask ViewController to display it.")
    }
}
