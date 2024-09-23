//
//  ButtonView.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

import SwiftUI

struct ButtonView: View {
    @StateObject private var viewModel: ButtonViewModel
    
    /// TODO: Refactor default value `Global.circleButtonDiameter` once dynamic button sizing migration work is complete
    init(type: ButtonViewType, invertColors: Bool = false, allocatedWidth: CGFloat = Global.iPhone15ScreenWidth) {
        self._viewModel = .init(wrappedValue: ButtonViewModel(type: type,
                                                              invertColors: invertColors,
                                                              allocatedScreenWidth: allocatedWidth))
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: viewModel.buttonHeight/2)
                .frame(width: viewModel.buttonWidth, height: viewModel.buttonHeight)
                .foregroundStyle(viewModel.buttonBackgroundColor)
            
            Text(viewModel.buttonLabel)
                .foregroundStyle(viewModel.buttonForegroundColor)
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
