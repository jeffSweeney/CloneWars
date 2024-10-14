//
//  ContactCardView.swift
//  ContactsClone
//
//  Created by Jeffrey Sweeney on 10/14/24.
//

import SwiftUI

struct ContactCardView: View {
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Spacer()
                    
                    ZStack {
                        let iconDiameter: CGFloat = geo.size.width / 5.1
                        
                        RoundedRectangle(cornerRadius: iconDiameter / 2)
                            .frame(width: iconDiameter, height: iconDiameter)
                            .foregroundStyle(LinearGradient.contactIconGradient)
                        
                        Text("JA")
                            .foregroundStyle(.white)
                            .font(.system(size: iconDiameter / 3))
                            .bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("John Appleseed")
                        .foregroundStyle(.white)
                        .font(.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    
                    let hstackSpacing = geo.size.width / 46
                    
                    HStack(spacing: hstackSpacing) {
                        let actionButtonWidth = (geo.size.width - (hstackSpacing * 6)) / 5
                        let actionButtonHeight = geo.size.height / 16.67
                        
                        ActionButtonView(action: .message, width: actionButtonWidth, height: actionButtonHeight)
                        ActionButtonView(action: .call, width: actionButtonWidth, height: actionButtonHeight)
                        ActionButtonView(action: .faceTime, width: actionButtonWidth, height: actionButtonHeight)
                        ActionButtonView(action: .mail, width: actionButtonWidth, height: actionButtonHeight)
                        ActionButtonView(action: .pay, width: actionButtonWidth, height: actionButtonHeight)
                    }
                    .padding(.bottom, 8)
                }
                .frame(maxWidth: .infinity)
                .frame(height: geo.size.height / 2.85)
                .background(LinearGradient.contactBannerGradient)
                
                // MARK: - TODO section
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        Text("C")
                        Text("Contact Photo & Poster")
                        Spacer()
                    }
                    
                }
                .padding()
            }
            .ignoresSafeArea(.all)
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    ContactCardView()
}
