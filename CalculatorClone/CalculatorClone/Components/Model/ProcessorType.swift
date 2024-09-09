//
//  ProcessorType.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

enum ProcessorType: Equatable, LabelProtocol {
    case ac
    case c
    case plusMinus
    case percentage
    
    var stringValue: String {
        switch self {
        case .ac:
            "AC"
        case .c:
            "C"
        case .plusMinus:
            "±"
        case .percentage:
            "%"
        }
    }
}
