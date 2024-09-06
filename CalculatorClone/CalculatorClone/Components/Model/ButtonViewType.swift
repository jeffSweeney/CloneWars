//
//  ButtonViewType.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

import SwiftUI

enum ButtonViewType: Equatable, LabelProtocol {
    case numeric(CalcNumericRange)
    case operand(OperandType)
    case resultProcessor(ProcessorType)
    
    var backgroundColor: Color {
        switch self {
        case .numeric:
            return .numeric
        case .operand:
            return .operand
        case .resultProcessor:
            return .resultProcessor
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .numeric, .operand:
            return .white
        case .resultProcessor:
            return .black
        }
    }
    
    var height: CGFloat {
        // Consistently fixed for now
        return Global.circleButtonDiameter
    }
    
    var width: CGFloat {
        return self == .numeric(.zero)
            ? (Global.circleButtonDiameter * 2) + Global.gridSpacing
            : Global.circleButtonDiameter
    }
    
    var label: String {
        switch self {
        case .numeric(let calcNumericRange):
            return calcNumericRange.label
        case .operand(let operandType):
            return operandType.label
        case .resultProcessor(let processorType):
            return processorType.label
        }
    }
}
