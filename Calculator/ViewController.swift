//
//  ViewController.swift
//  Calculator
//
//  Created by Tung Nguyen on 10/24/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var userInTheMiddleOfTyping = false
    
    //Outler, var display use to display on the UILabel!
    @IBOutlet private weak var display: UILabel!
    
    //creat an object of class CalculatorBrain
    private var brain = CalculatorBrain()

    // Action function, display.text is the display var upthere and .text
    @IBAction private func touchDigit(_ sender: UIButton){
        let digit = sender.currentTitle!
        if userInTheMiddleOfTyping{
            let textcurrentlyInDisplay=display.text!
            display.text = textcurrentlyInDisplay+digit
        }else{
            display.text = digit
        }
        userInTheMiddleOfTyping = true
        
    }
    //accessor and mutator
    //display value is a variable that help changing the display text
    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    @IBAction private func performOperation(_ sender: UIButton) {
        if userInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userInTheMiddleOfTyping = false

        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
        
    }
}

