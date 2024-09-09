//
//  ButtonViewType.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

import SwiftUI

enum ButtonViewType: Equatable, LabelProtocol {
    case numeric(CalcNumericRange)
    case `operator`(OperatorType)
    case resultProcessor(ProcessorType)
    
    var backgroundColor: Color {
        switch self {
        case .numeric:
            return .numeric
        case .operator:
            return .operator
        case .resultProcessor:
            return .resultProcessor
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .numeric, .operator:
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
    
    var stringValue: String {
        switch self {
        case .numeric(let calcNumericRange):
            return calcNumericRange.stringValue
        case .operator(let operatorType):
            return operatorType.stringValue
        case .resultProcessor(let processorType):
            return processorType.stringValue
        }
    }
}
