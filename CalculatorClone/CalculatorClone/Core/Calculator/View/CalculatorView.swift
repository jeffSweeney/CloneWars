//
//  CalculatorView.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

import SwiftUI

struct CalculatorView: View {
    // TODO: - Placeholder. Update with actual calculator business logic result
    var result = "0"
    
    var body: some View {
        VStack(spacing: 12) {
            Text(result)
                .font(.system(size: 60))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.9)
                .padding(.horizontal)
        
            Grid(horizontalSpacing: Global.gridSpacing, verticalSpacing: Global.gridSpacing) {
                GridRow {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .resultProcessor(.ac)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .resultProcessor(.plusMinus)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .resultProcessor(.percentage)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .operand(.divide)) })
                }
                
                GridRow {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.seven)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.eight)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.nine)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .operand(.multiply)) })
                }
                
                GridRow {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.four)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.five)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.six)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .operand(.subtraction)) })
                }
                
                GridRow {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.one)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.two)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.three)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .operand(.addition)) })
                }
                
                GridRow {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.zero)) }).gridCellColumns(2)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .numeric(.dot)) })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { ButtonView(type: .operand(.equals)) })
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
