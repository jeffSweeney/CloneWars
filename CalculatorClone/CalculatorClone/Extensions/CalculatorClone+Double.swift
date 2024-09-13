//
//  CalculatorClone+Double.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/12/24.
//

import Foundation

extension Double {
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
