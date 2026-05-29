//
//  SettingsView.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var settingsManager: SettingsManager
    @Binding var selectedTab: Int

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 24) {
                        headerSection
                        colorSummarySection
                        colorSelectionSection
                        actionButtons
                    }
                    .padding(24)
                }
            }
            .navigationTitle("Settings")
        }
    }

    var headerSection: some View {
        VStack(spacing: 10) {
            Image(systemName: "slider.horizontal.3")
                .font(.system(size: 54))
                .foregroundColor(.blue)

            Text("Game Settings")
                .font(.title.bold())

            Text("Select at least 2 colors. The game will randomly choose the target color from your selected colors.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 12)
    }

    var colorSummarySection: some View {
        HStack {
            Text("Selected Colors")
                .font(.headline)

            Spacer()

            Text("\(settingsManager.selectedColorCount)")
                .font(.title3.bold())
                .foregroundColor(.blue)
        }
        .padding(20)
        .background(.white)
        .cornerRadius(20)
    }

    var colorSelectionSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Select Colors")
                .font(.headline)

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ],
                spacing: 12
            ) {
                ForEach(settingsManager.availableColors) { gameColor in
                    ColorSelectionButton(
                        gameColor: gameColor,
                        isSelected: settingsManager.isSelected(gameColor)
                    ) {
                        settingsManager.toggleColor(gameColor)
                    }
                }
            }
        }
        .padding(20)
        .background(.white)
        .cornerRadius(20)
    }

    var actionButtons: some View {
        VStack(spacing: 12) {
            Button {
                selectedTab = 0
            } label: {
                Text("SAVE")
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.blue)
                    .cornerRadius(16)
            }

            Button {
                settingsManager.resetToDefault()
            } label: {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Reset to Default")
                }
                .font(.headline.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.red)
                .cornerRadius(16)
            }
        }
    }
}

#Preview {
    SettingsView(selectedTab: .constant(1))
        .environmentObject(SettingsManager())
}
