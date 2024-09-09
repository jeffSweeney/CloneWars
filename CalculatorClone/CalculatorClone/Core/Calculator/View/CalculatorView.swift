//
//  CalculatorView.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject var viewModel = CalculatorViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            Text(viewModel.displayedCurrentNumber)
                .font(.system(size: 65))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .padding(.horizontal)
        
            Grid(horizontalSpacing: Global.gridSpacing, verticalSpacing: Global.gridSpacing) {
                GridRow {
                    Button(action: { viewModel.clearCurrentInput() }, label: { ButtonView(type: viewModel.clearButton) })
                    Button(action: {}, label: { ButtonView(type: .resultProcessor(.plusMinus)) })
                    Button(action: {}, label: { ButtonView(type: .resultProcessor(.percentage)) })
                    Button(action: {}, label: { ButtonView(type: .operator(.divide)) })
                }
                
                GridRow {
                    Button(action: { viewModel.expandCurrentNumber(with: .seven) }, label: { ButtonView(type: .numeric(.seven)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .eight) }, label: { ButtonView(type: .numeric(.eight)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .nine) }, label: { ButtonView(type: .numeric(.nine)) })
                    Button(action: {}, label: { ButtonView(type: .operator(.multiply)) })
                }
                
                GridRow {
                    Button(action: { viewModel.expandCurrentNumber(with: .four) }, label: { ButtonView(type: .numeric(.four)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .five) }, label: { ButtonView(type: .numeric(.five)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .six) }, label: { ButtonView(type: .numeric(.six)) })
                    Button(action: {}, label: { ButtonView(type: .operator(.subtraction)) })
                }
                
                GridRow {
                    Button(action: { viewModel.expandCurrentNumber(with: .one) }, label: { ButtonView(type: .numeric(.one)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .two) }, label: { ButtonView(type: .numeric(.two)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .three) }, label: { ButtonView(type: .numeric(.three)) })
                    Button(action: {}, label: { ButtonView(type: .operator(.addition)) })
                }
                
                GridRow {
                    Button(action: { viewModel.expandCurrentNumber(with: .zero) }, label: { ButtonView(type: .numeric(.zero)) }).gridCellColumns(2)
                    Button(action: { viewModel.expandCurrentNumber(with: .dot) }, label: { ButtonView(type: .numeric(.dot)) })
                    Button(action: {}, label: { ButtonView(type: .operator(.equals)) })
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(.black)
    }
}

#Preview {
    CalculatorView()
}
