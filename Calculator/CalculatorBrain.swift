//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Tung Nguyen on 10/26/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    
    private var accumulator = 0.0
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        //Closure: redundant in 1 line function in Swift, using $0 and $1 as arg
        //Swift can smartly detect the arg as doubles
        //no need return as the orignal multiply functuon
        //it can even refer the return double so you dont need anything
        //{} indicate the "closure" in Swift
        "x" : Operation.BinaryOperation({$0 * $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "/" : Operation.BinaryOperation({$0 / $1}),
        "=" : Operation.Equals
    ]
    
    //type you capitalize first letter, local variable small letter
    private enum Operation{
    
        case Constant(Double)
        //declare type Function take a Double return a Double
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double)->Double
        var firstOperand: Double
    }
    
    func performOperation(symbol: String){

        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingOperation()
            }
    
        }
    }
    private func executePendingOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }

    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
}

