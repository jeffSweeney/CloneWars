//
//  ContactAction.swift
//  ContactsClone
//
//  Created by Jeffrey Sweeney on 10/14/24.
//

import Foundation

enum ContactAction {
    case message
    case call
    case faceTime
    case mail
    case pay
    
    var sfSymbol: String {
        switch self {
        case .message:
            "message.fill"
        case .call:
            "phone.fill"
        case .faceTime:
            "video.fill"
        case .mail:
            "envelope.fill"
        case .pay:
            "dollarsign"
        }
    }
    
    var title: String {
        switch self {
        case .message:
            "message"
        case .call:
            "call"
        case .faceTime:
            "FaceTime"
        case .mail:
            "mail"
        case .pay:
            "pay"
        }
    }
}
