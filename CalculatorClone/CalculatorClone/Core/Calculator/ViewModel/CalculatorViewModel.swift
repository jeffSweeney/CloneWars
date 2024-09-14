//
//  CalculatorViewModel.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/11/24.
//

import Foundation

final class CalculatorViewModel: ObservableObject {
    @Published var currentNumberString = "0"
    @Published var clearProcessor: ProcessorType = .ac
    @Published var operatorInvertingColor: OperatorType? = nil
    
    private var overwriteCurrentNumber = true
    private var currentScroll = ""
    private var lastOperator: OperatorType? = nil
    
    @MainActor
    func expandCurrentNumber(with button: CalcNumericRange) {
        operatorInvertingColor = nil
        if clearProcessor == .ac && button != .zero { clearProcessor = .c }
        
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
        case .ac:
            clearAll()
            
        case .c:
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
        // Indicates to the user what they're about to operate with
        operatorInvertingColor = tappedOperator == .equals ? nil : tappedOperator
        
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
    func clearAll() {
        currentNumberString = "0"
        overwriteCurrentNumber = true
        currentScroll = ""
        lastOperator = nil
        operatorInvertingColor = nil
    }
    
    @MainActor
    func clearCurrentInput() {
        currentNumberString = "0"
        overwriteCurrentNumber = true
        clearProcessor = .ac
    }
}
