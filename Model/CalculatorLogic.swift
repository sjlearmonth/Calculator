//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Stephen Learmonth on 26/04/2022.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    internal func execute(_ symbol: String, _ number: Double) -> Double? {
        
        var number: Double? = number
        
        if symbol == "+/-" {
            number! *= -1
            return number
        } else if symbol == "AC" {
            number = 0.0
            return number
        } else if symbol == "%" {
            number! /= 100.0
            return number
        } else {
            return nil
        }
    }
}
