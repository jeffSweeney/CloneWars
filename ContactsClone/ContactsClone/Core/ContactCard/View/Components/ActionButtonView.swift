//
//  ActionButtonView.swift
//  ContactsClone
//
//  Created by Jeffrey Sweeney on 10/14/24.
//

import SwiftUI

struct ActionButtonView: View {
    let action: ContactAction
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: width, height: height)
                .foregroundStyle(.actionButton.opacity(0.75))
            
            VStack(spacing: 4) {
                Image(systemName: action.sfSymbol)
                    .resizable()
                    .scaledToFit()
                    .frame(height: height/3)
                
                Text(action.title)
                    .font(.caption2)
                    .frame(height: height * 0.3)
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    HStack {
        ActionButtonView(action: .message, width: 80, height: 50)
        ActionButtonView(action: .faceTime, width: 80, height: 50)
        ActionButtonView(action: .pay, width: 80, height: 50)
    }
}
