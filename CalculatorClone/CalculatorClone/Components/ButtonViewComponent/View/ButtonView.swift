//
//  ButtonView.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

import SwiftUI

struct ButtonView: View {
    @ObservedObject private var viewModel: ButtonViewModel
    
    init(type: ButtonViewType, invertColors: Bool = false, allocatedScreenWidth: CGFloat) {
        _viewModel = ObservedObject(wrappedValue: ButtonViewModel(type: type,
                                                                  invertColors: invertColors,
                                                                  allocatedScreenWidth: allocatedScreenWidth))
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
    ButtonView(type: .numeric(.nine), allocatedScreenWidth: Global.iPhone15ScreenWidth)
}

#Preview("Dot") {
    ButtonView(type: .numeric(.dot), allocatedScreenWidth: Global.iPhone15ScreenWidth)
}

#Preview("Zero") {
    ButtonView(type: .numeric(.zero), allocatedScreenWidth: Global.iPhone15ScreenWidth)
}

// MARK: - Operator Button Previews
#Preview("Division") {
    ButtonView(type: .operator(.division), allocatedScreenWidth: Global.iPhone15ScreenWidth)
}

#Preview("Division-Inverted") {
    ButtonView(type: .operator(.division), invertColors: true, allocatedScreenWidth: Global.iPhone15ScreenWidth)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
}

// MARK: - Result Processor Button Previews
#Preview("PlusMinus") {
    ButtonView(type: .resultProcessor(.plusMinus), allocatedScreenWidth: Global.iPhone15ScreenWidth)
}

#Preview("AC") {
    ButtonView(type: .resultProcessor(.ac), allocatedScreenWidth: Global.iPhone15ScreenWidth)
}

#Preview("C") {
    ButtonView(type: .resultProcessor(.c), allocatedScreenWidth: Global.iPhone15ScreenWidth)
}
