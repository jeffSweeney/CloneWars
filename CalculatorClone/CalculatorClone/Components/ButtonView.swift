//
//  ButtonView.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

import SwiftUI

struct ButtonView: View {
    let type: ButtonViewType
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: type.height/2)
                .frame(width: type.width, height: type.height)
                .foregroundStyle(type.backgroundColor)
            
            Text(type.stringValue)
                .foregroundStyle(type.foregroundColor)
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
