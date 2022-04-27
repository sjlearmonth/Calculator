//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Stephen Learmonth on 26/04/2022.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating internal func setNumber(to number: Double) {
        self.number = number
    }
    
    mutating internal func calculate(symbol: String) -> (Double?, String?) {
        
        if let n = number {
            switch symbol {
            case "+/-":
                return (n * -1, nil)
            case "AC":
                return (0.0, nil)
            case "%":
                return (n * 0.01, nil)
            case "=":
                return performTwoNumCalculation(n2: n)
            default:
                intermediateCalculation = (n1: n, calcMethod: symbol)
                return(nil, nil)
            }
        } else {
            return (nil, "number not set")
        }
    }
    
    private func performTwoNumCalculation(n2: Double) -> (Double?, String?) {
        
        if let n1 = intermediateCalculation?.n1,
           let operation = intermediateCalculation?.calcMethod {
            
            switch operation {
            case "+":
                return (n1 + n2, nil)
            case "-":
                return (n1 - n2, nil)
            case "×":
                return (n1 * n2, nil)
            case "÷":
                if n2 != 0.0 {
                    return (n1 / n2, nil)
                } else {
                    return (nil, "Divide by zero!")
                }
            default:
                fatalError("In 'performTwoNumCalculation(n2:)'. the operation being passed in does not match any of the cases.")
            }
        }
        return (nil, "Not possible.")
    }
}
