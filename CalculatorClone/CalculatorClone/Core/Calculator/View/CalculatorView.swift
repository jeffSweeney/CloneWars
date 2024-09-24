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
        GeometryReader { geo in
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
                        buildProcessorButton(for: viewModel.clearProcessor)
                        buildProcessorButton(for: .plusMinus)
                        buildProcessorButton(for: .percentage)
                        buildOperatorButton(for: .division)
                    }
                    
                    GridRow {
                        buildNumericButton(for: .seven)
                        buildNumericButton(for: .eight)
                        buildNumericButton(for: .nine)
                        buildOperatorButton(for: .multiplication)
                    }
                    
                    GridRow {
                        buildNumericButton(for: .four)
                        buildNumericButton(for: .five)
                        buildNumericButton(for: .six)
                        buildOperatorButton(for: .subtraction)
                    }
                    
                    GridRow {
                        buildNumericButton(for: .one)
                        buildNumericButton(for: .two)
                        buildNumericButton(for: .three)
                        buildOperatorButton(for: .addition)
                    }
                    
                    GridRow {
                        buildNumericButton(for: .zero).gridCellColumns(2)
                        buildNumericButton(for: .dot)
                        buildOperatorButton(for: .equals)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .background(.black)
            .onAppear {
                viewModel.updateScreenWidth(with: geo.size.width)
            }
        }
    }
}

// MARK: - Button Constructors
extension CalculatorView {
    private func buildProcessorButton(for processor: ProcessorType) -> some View {
        let view = ButtonView(type: .resultProcessor(processor), allocatedScreenWidth: viewModel.screenWidth)
        
        return Button(action: { viewModel.processCurrentNumber(with: processor) }, label: { view })
    }
    
    private func buildOperatorButton(for op: OperatorType) -> some View {
        let view = ButtonView(type: .operator(op), 
                              invertColors: viewModel.operatorInvertingColor == op,
                              allocatedScreenWidth: viewModel.screenWidth)
        
        return Button(action: { viewModel.setOperator(with: op) }, label: { view })
    }
    
    private func buildNumericButton(for numeric: CalcNumericRange) -> some View {
        let view = ButtonView(type: .numeric(numeric), allocatedScreenWidth: viewModel.screenWidth)
        
        return Button(action: { viewModel.expandCurrentNumber(with: numeric) }, label: { view })
    }
}

#Preview {
    CalculatorView()
}
