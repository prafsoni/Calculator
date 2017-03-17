//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Prafull Kumar Soni on 6/21/16.
//  Copyright © 2016 pksprojects. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func set(operand: Double) {
        accumulator = operand
    }
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        case AllClear
    }
    
    private var operations: Dictionary<String, Operation> = [
        "∏" : Operation.Constant(M_PI),
        "cos" : Operation.UnaryOperation(cos),
        "√" : Operation.UnaryOperation(sqrt),
        "±" : Operation.UnaryOperation({-$0}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "−" : Operation.BinaryOperation({$0 - $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "=" : Operation.Equals,
        "%" : Operation.UnaryOperation({$0 / 100}),
        "AC": Operation.AllClear
    ]
    
    func perform(operation: String) {
        if let operation = operations[operation]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let unary):
                accumulator = unary(accumulator)
            case .BinaryOperation(let binaryFunction):
                executePendingBinaryOperations()
                pending = PendingBinaryOperationInfo(binaryFunction: binaryFunction, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperations()
            case .AllClear:
                accumulator = 0.0
                pending = nil
            }
        }
    }
    
    private func executePendingBinaryOperations(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
        
    private struct PendingBinaryOperationInfo{
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
        
    var result: Double{
        get{
            return accumulator
        }
    }
}
