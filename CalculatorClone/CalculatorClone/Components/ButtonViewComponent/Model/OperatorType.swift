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
    
    var asNSExpressionFormat: String {
        switch self {
        case .equals:
            "="
        case .addition:
            "+"
        case .subtraction:
            "-"
        case .multiplication:
            "*"
        case .division:
            "/"
        }
    }
    
    func isGreaterOrEqual(to otherOperator: OperatorType) -> Bool {
        switch self {
        case .equals, .multiplication, .division:
            return true
        case .addition, .subtraction:
            return otherOperator == .addition || otherOperator == .subtraction
        }
    }
}
