//
//  CalculatorViewModel.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/11/24.
//

import Foundation

final class CalculatorViewModel: ObservableObject {
    @Published var currentNumberString = "0"
    
    private var overwriteCurrentNumber = true
    private var currentScroll = ""
    private var lastOperator: OperatorType? = nil
    
    @MainActor
    func expandCurrentNumber(with button: CalcNumericRange) {
        guard !overwriteCurrentNumber else {
            overwriteCurrentNumber = false
            
            if button == .dot {
                currentNumberString = "0."
            } else {
                currentNumberString = button.stringValue
            }
            
            return
        }
        
        var newNumber = currentNumberString.replacingOccurrences(of: ",", with: "") // strip the formatting for processing
        let components = newNumber.split(separator: ".")
        let digitsToLeft = components[0].count
        let digitsToRight = components.count > 1 ? components[1].count : 0
        
        // Edge case: Restrict total input digits to 9 max
        guard (digitsToLeft + digitsToRight) < 9 else { return }
        
        // Edge case: No multiple decimal input
        if button == .dot && (components.count > 1 || newNumber.last == ".") { return }
        
        newNumber += button.stringValue
        currentNumberString = newNumber.asCalculatorRendering ?? currentNumberString
    }
    
    @MainActor
    func processCurrentNumber(with processor: ProcessorType) {
        switch processor {
        case .ac, .c: // TODO: Currently handled same way - Update
            clearCurrentInput()
            
        case .percentage:
            let currentResult = currentNumberString.fromCalculatorRendering
            currentNumberString = (currentResult / 100).asCalculatorRendering
            
        case .plusMinus:
            let currentResult = currentNumberString.fromCalculatorRendering
            currentNumberString = (currentResult * -1).asCalculatorRendering
        }
    }
    
    @MainActor
    func setOperator(with tappedOperator: OperatorType) {
        guard let lastOperator else {
            if tappedOperator != .equals {
                overwriteCurrentNumber = true
                currentScroll +=
                    "\(currentNumberString.fromCalculatorRendering)\(tappedOperator.asNSExpressionFormat)"
                lastOperator = tappedOperator
            }
            
            return
        }
        
        // We have a lastOperator
        switch tappedOperator {
        case .equals, .addition, .subtraction:
            reduceScroll(with: tappedOperator)
        case .multiplication, .division:
            if lastOperator.isGreaterOrEqual(to: tappedOperator) {
                reduceScroll(with: tappedOperator)
            } else {
                overwriteCurrentNumber = true
                currentScroll += "\(currentNumberString.fromCalculatorRendering)\(tappedOperator.asNSExpressionFormat)"
                self.lastOperator = tappedOperator
            }
        }
    }
    
    @MainActor
    private func reduceScroll(with tappedOperator: OperatorType) {
        currentScroll += "\(currentNumberString.fromCalculatorRendering)"
        let reduction: Double = currentScroll.evaluateExpression() ?? 0 // TODO: Better error handling
        currentNumberString = reduction.asCalculatorRendering
        
        if tappedOperator != .equals {
            currentScroll = "\(currentNumberString.fromCalculatorRendering)\(tappedOperator.asNSExpressionFormat)"
            lastOperator = tappedOperator
            overwriteCurrentNumber = true
        } else {
            currentScroll = ""
            lastOperator = nil
            overwriteCurrentNumber = false
        }
    }
    
    @MainActor
    func clearCurrentInput() {
        currentNumberString = "0"
        overwriteCurrentNumber = true
        currentScroll = ""
        lastOperator = nil
    }
}

// MARK: - Helpful internal extensions to this file

fileprivate extension String {
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = true
        
        return formatter
    }()
    
    var asCalculatorRendering: String? {
        // Split the string by the decimal point if there is one
        let components = self.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: false)
        
        guard let integerPart = components.first else { return nil }
        
        // Convert the integer part to a formatted string
        if let formattedIntegerPart = Self.formatter.string(for: Double(integerPart)) {
            // If there's a decimal part, append it back to the formatted integer part
            if components.count > 1, let decimalPart = components.last {
                return formattedIntegerPart + "." + decimalPart
            }
            return formattedIntegerPart
        }
        
        return nil
    }
    
    var fromCalculatorRendering: Double {
        return Double(self.replacingOccurrences(of: ",", with: "")) ?? 0
    }
    
    func evaluateExpression() -> Double? {
        let exp = NSExpression(format: self)
        return exp.expressionValue(with: nil, context: nil) as? Double
    }
}

fileprivate extension Double {
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 9
        formatter.usesGroupingSeparator = true
        
        return formatter
    }()
    
    var asCalculatorRendering: String {
        guard abs(self) < 1e9 else { return String(format: "%.0e", self) }
        
        if let formattedNumber = Self.formatter.string(for: self) { return formattedNumber }
        
        return "Error" // Not sure how this is reached, but I'll keep it for debugging at the least.
    }
}
