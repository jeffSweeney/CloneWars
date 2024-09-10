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
    case multiply
    case divide
    
    var stringValue: String {
        switch self {
        case .equals:
            "="
        case .addition:
            "+"
        case .subtraction:
            "–"
        case .multiply:
            "×"
        case .divide:
            "÷"
        }
    }
}
