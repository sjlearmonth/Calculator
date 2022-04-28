//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Controls the state of the app when a number is entered
    private var isFinishedTypingNumber: Bool = true
    
    /// Controls when decimal point is displayed or not
    private var isFinishedTypingDecimalPoint: Bool = false
    
    private var errorMessageIsDisplayed: Bool = false
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert displayLabel text to a Double.") }
            return number
        }
        set {
            if newValue == 0.0 {
                displayLabel.text = "0"
            } else {
                displayLabel.text = String(format: "%1.2f", arguments: [newValue])
            }
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        
        isFinishedTypingNumber = true
        
        if let calcMethod = sender.currentTitle {
            
            if !errorMessageIsDisplayed {
                
                calculator.setNumber(to: displayValue)
                let returnValue = calculator.calculate(symbol: calcMethod)
                if let result = returnValue.0 {
                    displayValue = result
                } else if let displayMessage = returnValue.1 {
                    displayLabel.text = displayMessage
                    errorMessageIsDisplayed = true
                }
                
            } else if calcMethod == "AC" {
                displayValue = 0.0
                errorMessageIsDisplayed = false
            }
        }
        
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                if numValue == "." {
                    isFinishedTypingDecimalPoint = true
                    displayLabel.text = "0" + numValue
                } else {
                    isFinishedTypingDecimalPoint = false
                    displayLabel.text = numValue
                }
                isFinishedTypingNumber = false
                
            } else {
                if !isFinishedTypingDecimalPoint && numValue == "." {
                    isFinishedTypingDecimalPoint = true
                    displayLabel.text?.append(numValue)
                } else if numValue != "." {
                    displayLabel.text?.append(numValue)
                }
            }
        }
    }
}
