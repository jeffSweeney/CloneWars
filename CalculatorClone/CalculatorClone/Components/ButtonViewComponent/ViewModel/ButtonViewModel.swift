//
//  ButtonViewModel.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/23/24.
//

import SwiftUI

class ButtonViewModel: ObservableObject {
    private let type: ButtonViewType
    private let invertColors: Bool
    private let circleButtonDiameter: CGFloat
    
    init(type: ButtonViewType, invertColors: Bool, allocatedScreenWidth: CGFloat) {
        self.type = type
        self.invertColors = invertColors
        self.circleButtonDiameter = Self.computeButtonDiameter(from: allocatedScreenWidth)
    }
    
    // MARK: - Color Properties
    private var buttonColor: (background: Color, foreground: Color) {
        guard !invertColors else {
            return (background: type.foregroundColor, foreground: type.backgroundColor)
        }
       
        return (background: type.backgroundColor, foreground: type.foregroundColor)
    }
    
    var buttonBackgroundColor: Color { buttonColor.background }
    var buttonForegroundColor: Color { buttonColor.foreground }
    
    // MARK: - Size Properties
    var buttonHeight: CGFloat { circleButtonDiameter }
    var buttonWidth: CGFloat {
        guard type != .numeric(.zero) else {
            return circleButtonDiameter * 2 + Global.gridSpacing
        }
        
        return circleButtonDiameter
    }
    
    // MARK: - Text Properties
    var buttonLabel: String { type.stringValue }
}

// MARK: - Static Construction Helper
extension ButtonViewModel {
    private static func computeButtonDiameter(from screenWidth: CGFloat) -> CGFloat {
        let totalGridSpacers: CGFloat = 5
        let cumulativeGridSpacing = Global.gridSpacing * totalGridSpacers
        let cumulativeButtonSpaceInRow = screenWidth - cumulativeGridSpacing
        let typicalButtonsPerRow: CGFloat = 4
        
        return cumulativeButtonSpaceInRow / typicalButtonsPerRow
    }
}
