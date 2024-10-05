//
//  RootView.swift
//  ContactsClone
//
//  Created by Jeffrey Sweeney on 10/5/24.
//

import SweeneyCloneWarsIntro
import SwiftUI

struct RootView: View {
    @State var showingIntro = true
    
    var body: some View {
        if showingIntro {
            SweeneyCloneWarsIntro(showingIntro: $showingIntro,
                                  episodeNumber: 2,
                                  appName: "iPhone Contacts App")
        } else {
            TempContactsClone()
        }
    }
}

#Preview {
    RootView()
}

struct TempContactsClone: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Contacts!")
        }
        .padding()
    }
}
