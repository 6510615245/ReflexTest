//
//  ReflexTestAppView.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct ReflexTestAppView: View {
    @StateObject private var gameManager = GameManager()

    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .environmentObject(gameManager)
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .tint(.blue)
    }
}

#Preview {
    ReflexTestAppView()
}
