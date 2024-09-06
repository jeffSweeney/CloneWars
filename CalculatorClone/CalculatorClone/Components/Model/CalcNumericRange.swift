//
//  CalcNumericRange.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

enum CalcNumericRange: Equatable, LabelProtocol {
    case zero
    case one
    case two
    case three
    case four
    case five
    case size
    case seven
    case eight
    case nine
    case dot
    
    var label: String {
        switch self {
        case .zero:
            "0"
        case .one:
            "1"
        case .two:
            "2"
        case .three:
            "3"
        case .four:
            "4"
        case .five:
            "5"
        case .size:
            "6"
        case .seven:
            "7"
        case .eight:
            "8"
        case .nine:
            "9"
        case .dot:
            "."
        }
    }
}
