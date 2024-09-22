//
//  CalculatorCloneApp.swift
//  CalculatorClone
//
//  Created by Jeffrey Sweeney on 9/5/24.
//

import SweeneyCloneWarsIntro
import SwiftUI

@main
struct CalculatorCloneApp: App {
    @State var showingIntro = true
    
    private let episode: UInt8 = 1
    private let appName = "iPhone Calculator"
    
    var body: some Scene {
        WindowGroup {
            if showingIntro {
                SweeneyCloneWarsIntro(showingIntro: $showingIntro, episodeNumber: episode, appName: appName)
            } else {
                CalculatorView()
            }
        }
    }
}

