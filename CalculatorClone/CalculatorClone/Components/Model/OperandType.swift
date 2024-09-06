//
//  OperandType.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

enum OperandType: Equatable, LabelProtocol {
    case equals
    case addition
    case subtraction
    case multiply
    case divide
    
    var label: String {
        switch self {
        case .equals:
            "="
        case .addition:
            "+"
        case .subtraction:
            "-"
        case .multiply:
            "x"
        case .divide:
            "/"
        }
    }
}