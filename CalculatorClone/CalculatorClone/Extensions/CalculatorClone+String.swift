//
//  CalculatorClone+String.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/12/24.
//

import Foundation

extension String {
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
