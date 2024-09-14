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
            Text(viewModel.currentNumberString)
                .font(.system(size: 65))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .padding(.horizontal)
        
            Grid(horizontalSpacing: Global.gridSpacing, verticalSpacing: Global.gridSpacing) {
                GridRow {
                    Button(action: { viewModel.processCurrentNumber(with: viewModel.clearProcessor) },
                           label: { ButtonView(type: .resultProcessor(viewModel.clearProcessor)) })
                    Button(action: { viewModel.processCurrentNumber(with: .plusMinus) }, label: { ButtonView(type: .resultProcessor(.plusMinus)) })
                    Button(action: { viewModel.processCurrentNumber(with: .percentage) }, label: { ButtonView(type: .resultProcessor(.percentage)) })
                    buildOperatorButton(for: .division)
                }
                
                GridRow {
                    Button(action: { viewModel.expandCurrentNumber(with: .seven) }, label: { ButtonView(type: .numeric(.seven)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .eight) }, label: { ButtonView(type: .numeric(.eight)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .nine) }, label: { ButtonView(type: .numeric(.nine)) })
                    buildOperatorButton(for: .multiplication)
                }
                
                GridRow {
                    Button(action: { viewModel.expandCurrentNumber(with: .four) }, label: { ButtonView(type: .numeric(.four)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .five) }, label: { ButtonView(type: .numeric(.five)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .six) }, label: { ButtonView(type: .numeric(.six)) })
                    buildOperatorButton(for: .subtraction)
                }
                
                GridRow {
                    Button(action: { viewModel.expandCurrentNumber(with: .one) }, label: { ButtonView(type: .numeric(.one)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .two) }, label: { ButtonView(type: .numeric(.two)) })
                    Button(action: { viewModel.expandCurrentNumber(with: .three) }, label: { ButtonView(type: .numeric(.three)) })
                    buildOperatorButton(for: .addition)
                }
                
                GridRow {
                    Button(action: { viewModel.expandCurrentNumber(with: .zero) }, label: { ButtonView(type: .numeric(.zero)) }).gridCellColumns(2)
                    Button(action: { viewModel.expandCurrentNumber(with: .dot) }, label: { ButtonView(type: .numeric(.dot)) })
                    buildOperatorButton(for: .equals)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(.black)
    }
    
    private func buildOperatorButton(for op: OperatorType) -> some View {
        return Button(action: {
            viewModel.setOperator(with: op)
        }, label: {
            ButtonView(type: .operator(op), invertColors: viewModel.operatorInvertingColor == op)
        })
    }
}

#Preview {
    CalculatorView()
}
