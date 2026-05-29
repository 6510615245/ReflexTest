//
//  ReflexTestAppView.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct ReflexTestAppView: View {

    @StateObject private var gameManager = GameManager()
    @StateObject private var settingsManager = SettingsManager()
    @StateObject private var navigationManager = AppNavigationManager()

    var body: some View {
        TabView(selection: $navigationManager.selectedTab) {
            NavigationStack {
                HomeView()
            }
            .environmentObject(gameManager)
            .environmentObject(settingsManager)
            .environmentObject(navigationManager)
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(0)

            SettingsView(selectedTab: $navigationManager.selectedTab)
                .environmentObject(settingsManager)
                .environmentObject(navigationManager)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(1)
        }
        .tint(.blue)
    }
}

#Preview {
    ReflexTestAppView()
}
