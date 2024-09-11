//
//  CalculatorViewModel.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/6/24.
//

import Foundation

final class CalculatorViewModel: ObservableObject {
    @Published private (set) var displayedCurrentNumber = "0" // TODO: This does not suffice. Values in the billions will set at 1 billion even.
    @Published private (set) var clearButton: ButtonViewType = .resultProcessor(.ac)
    
    private var priorNumber: Double = 0
    private var currentOperator: OperatorType? = nil
    
    @MainActor
    func expandCurrentNumber(with button: CalcNumericRange) {
        var newNumber = displayedCurrentNumber.replacingOccurrences(of: ",", with: "") // strip the formatting for processing
        let components = newNumber.split(separator: ".")
        let digitsToLeft = components[0].count
        let digitsToRight = components.count > 1 ? components[1].count : 0
        
        // Edge case: Restrict total input digits to 9 max
        guard (digitsToLeft + digitsToRight) < 9 else { return }
        
        // Edge case: No multiple decimal input
        if button == .dot && (components.count > 1 || newNumber.last == ".") { return }
        
        // Edge case: Default value is 0. If still 0, overwrite as long as first input wasn't a dot.
        if displayedCurrentNumber == "0" && button != .dot {
            newNumber = button.stringValue
        } else {
            newNumber += button.stringValue
        }
        
        if displayedCurrentNumber == "0" { clearButton = .resultProcessor(.c) }
        displayedCurrentNumber = newNumber.asCalculatorRendering ?? displayedCurrentNumber
    }
    
    @MainActor
    func clearCurrentInput() {
        displayedCurrentNumber = "0"
        clearButton = .resultProcessor(.ac)
    }
    
    @MainActor
    func setOperation(with newOperator: OperatorType) {
        switch newOperator {
        case .equals:
            if let operatorToProcess = currentOperator {
                let newCurrentNumber = operatorToProcess.processOperands(left: priorNumber,
                                                                         right: displayedCurrentNumber.fromCalculatorRendering ?? 0)
                displayedCurrentNumber = newCurrentNumber.asCalculatorRendering
                priorNumber = 0
                currentOperator = nil
            }
            
        case .addition, .subtraction:
            let newPriorNumber: Double
            
            if let operatorToProcess = currentOperator {
                newPriorNumber = operatorToProcess.processOperands(left: priorNumber,
                                                                   right: displayedCurrentNumber.fromCalculatorRendering ?? 0)
            } else {
                newPriorNumber = displayedCurrentNumber.fromCalculatorRendering ?? 0
            }
            
            priorNumber = newPriorNumber
            currentOperator = newOperator
            displayedCurrentNumber = "0"
            
        case .multiplication:
            break
            
        case .division:
            break
            
        }
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
    
    var fromCalculatorRendering: Double? {
        return Double(self.replacingOccurrences(of: ",", with: ""))
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
