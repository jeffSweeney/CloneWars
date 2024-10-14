//
//  ContactsClone+LinearGradient.swift
//  ContactsClone
//
//  Created by Jeffrey Sweeney on 10/14/24.
//

import SwiftUI

extension LinearGradient {
    static let contactBannerGradient: Self = {
        let gradient = Gradient(colors: [.contactBannerL1, .contactBannerL2])
        
        return LinearGradient(gradient: gradient,
                              startPoint: .top,
                              endPoint: .bottom)
    }()
    
    static let contactIconGradient: Self = {
        let gradient = Gradient(colors: [.contactIconL1, .contactIconL2])
        
        return LinearGradient(gradient: gradient,
                              startPoint: .top,
                              endPoint: .bottom)
    }()
}
