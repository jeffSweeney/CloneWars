//
//  OperatorType.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

enum OperatorType: Equatable, LabelProtocol {
    case equals
    case addition
    case subtraction
    case multiplication
    case division
    
    var stringValue: String {
        switch self {
        case .equals:
            "="
        case .addition:
            "+"
        case .subtraction:
            "–"
        case .multiplication:
            "×"
        case .division:
            "÷"
        }
    }
    
    func processOperands(left: Double, right: Double) -> Double {
        switch self {
        case .equals:
            return 0 // TODO: Special Logic
        case .addition:
            return left + right
        case .subtraction:
            return left - right
        case .multiplication:
            return left * right
        case .division:
            guard right != 0 else { return 0 } // TODO: Error handling
            
            return left / right
        }
    }
}
