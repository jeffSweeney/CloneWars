//
//  ButtonView.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

import SwiftUI

struct ButtonView: View {
    let type: ButtonViewType
    let invertColors: Bool
    
    /// TODO: Refactor default value `Global.circleButtonDiameter` once dynamic button sizing migration work is complete
    init(type: ButtonViewType, invertColors: Bool = false) {
        self.type = type
        self.invertColors = invertColors
    }
    
    var buttonColor: (background: Color, foreground: Color) {
        guard !invertColors else {
            return (background: type.foregroundColor, foreground: type.backgroundColor)
        }
       
        return (background: type.backgroundColor, foreground: type.foregroundColor)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: type.height/2)
                .frame(width: type.width, height: type.height)
                .foregroundStyle(buttonColor.background)
            
            Text(type.stringValue)
                .foregroundStyle(buttonColor.foreground)
                .font(.largeTitle)
        }
    }
}

// MARK: - Numberic Button Previews
#Preview("Nine") {
    ButtonView(type: .numeric(.nine))
}

#Preview("Dot") {
    ButtonView(type: .numeric(.dot))
}

#Preview("Zero") {
    ButtonView(type: .numeric(.zero))
}

// MARK: - Operator Button Previews
#Preview("Division") {
    ButtonView(type: .operator(.division))
}

#Preview("Division-Inverted") {
    ButtonView(type: .operator(.division), invertColors: true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
}

// MARK: - Result Processor Button Previews
#Preview("PlusMinus") {
    ButtonView(type: .resultProcessor(.plusMinus))
}

#Preview("AC") {
    ButtonView(type: .resultProcessor(.ac))
}

#Preview("C") {
    ButtonView(type: .resultProcessor(.c))
}
