////
////  ViewController.swift
////  Currencies
////
////  Created by Jakub Hutny on 02.11.2016.
////  Copyright © 2016 Jakub Hutny. All rights reserved.
////
//
//import UIKit
//import SwiftyJSON
//
//class CalculatorViewController: UIViewController, CurrencyPickerViewDelegate, OutputDataViewDelegate {
//    private var apiManager: RestApiManagerProtocol?
//    public var ApiManager: RestApiManagerProtocol? {
//        get {
//            return apiManager
//        }
//        set {
//            apiManager = newValue
//        }
//    }
////    private var apiManager = RestApiManager()
//    private var calculator = Calculator.sharedInstance
//    private var date: String?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setApiManagerIfNull()
//        currencyPickerView.delegate = self
//        outputDataView.delegate = self
//        loadDataToPickerView()
//        getDate()
//        loadNeededMessages()
//        dismissKeyboardWhenTap()
//        
//        NotificationCenter.default.addObserver(self, selector:
//            #selector(CalculatorViewController.setOutputLabel), name: NSNotification.Name(rawValue: "PickerViewValueChanged"), object: nil)
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    
//    // CURRENCY PICKER VIEW OUTLETS
//    @IBOutlet weak var currencyPickerView: CurrencyPickerView!
//    @IBOutlet weak var inputInformationLabel: UILabel!
//    @IBOutlet weak var outputInformationLabel: UILabel!
//    @IBOutlet weak var inputCurrencyPickerView: UIPickerView!
//    @IBOutlet weak var outputCurrencyPickerView: UIPickerView!
//    
//    @IBOutlet weak var inputTextField: UITextField!
//    
//    // OUTPUT DATA VIEW OUTLETS
//    @IBOutlet weak var outputDataView: OutputDataView!
//    @IBOutlet weak var outputLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//    
//    @IBAction func inputTextBoxValueChanged(_ sender: Any) {
//        setOutputLabel()
//    }
//    
//    @IBAction func inputTextBoxEditingDidEnd(_ sender: Any) {
//        setOutputLabel()
//    }
//    
//    // UI CHANGING METHODS
//    func setOutputLabel() {
//        let inputCurrency = self.currencyPickerView.getCurrency(from: inputCurrencyPickerView)
//        let outputCurrency = self.currencyPickerView.getCurrency(from: outputCurrencyPickerView)
//        let inputValue = Double(inputTextField.text!)
//        
//        outputDataView.setOutputValue(inputCurrency: inputCurrency, outputCurrency: outputCurrency, inputValue: inputValue, outputLabel: outputLabel)
//    }
//    
//    func loadNeededMessages() {
//
//        outputLabel.font = UIFont(name: "Helvetica Neue", size: 60.0)
//        outputLabel.text = NSString(format: "%.3f", 0.000) as String
//    }
//    
//    func loadDateLabel() {
////        dateLabel.text = language.dateInformation + self.date! + "."
//    }
//    
//    func dismissKeyboardWhenTap() {
//        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CalculatorViewController.dismissKeyboard)))
//    }
//    
//    func dismissKeyboard() {
//        view.endEditing(true)
//    }
//
//    // PRIVATE METHODS
//    private func loadDataToPickerView() {
//        self.currencyPickerView.PickerViewData.append(CurrencyObject(key: "EUR", value: "1.00"))
//        apiManager?.getLatestCurrencyData { (json: JSON) in
//            if let results = json["rates"].dictionary {
//                for entry in results {
//                    self.currencyPickerView.PickerViewData.append(CurrencyObject(key: entry.key, value: entry.value))
//                }
//                DispatchQueue.main.async {
//                    self.currencyPickerView.setPickerViewDelegate(pickerView: self.inputCurrencyPickerView)
//                    self.currencyPickerView.setPickerViewDataSource(pickerView: self.inputCurrencyPickerView)
//                    self.currencyPickerView.setPickerViewDelegate(pickerView: self.outputCurrencyPickerView)
//                    self.currencyPickerView.setPickerViewDataSource(pickerView: self.outputCurrencyPickerView)
//                }
//            }
//        }
//    }
//    
//    private func getDate() {
//        apiManager?.getLatestCurrencyData { (json: JSON) in
//            self.date = json["date"].stringValue
//            self.loadDateLabel()
//        }
//    }
//    
//    private func setApiManagerIfNull() {
//        if apiManager == nil {
//            apiManager = RestApiManager()
//        }
//    }
//}
//
