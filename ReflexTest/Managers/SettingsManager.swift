//
//  SettingsManager.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import Foundation
import SwiftUI
import Combine

class SettingsManager: ObservableObject {

    @Published var selectedColorNames: [String] = GameSettings.defaultColors

    let availableColors: [GameColor] = [
        GameColor(name: "BLUE", color: .blue),
        GameColor(name: "RED", color: .red),
        GameColor(name: "GREEN", color: .green),
        GameColor(name: "YELLOW", color: .yellow),
        GameColor(name: "PURPLE", color: .purple),
        GameColor(name: "ORANGE", color: .orange),
        GameColor(name: "PINK", color: .pink),
        GameColor(name: "CYAN", color: .cyan)
    ]

    var selectedColors: [GameColor] {
        availableColors.filter { color in
            selectedColorNames.contains(color.name)
        }
    }

    var selectedColorCount: Int {
        selectedColorNames.count
    }

    init() {
        loadSettings()
        validateSelection()
    }

    func isSelected(_ color: GameColor) -> Bool {
        selectedColorNames.contains(color.name)
    }

    func toggleColor(_ color: GameColor) {
        if isSelected(color) {
            if selectedColorNames.count > 2 {
                selectedColorNames.removeAll { $0 == color.name }
            }
        } else {
            selectedColorNames.append(color.name)
        }

        saveSettings()
    }

    func setColorCount(_ newCount: Int) {
        let safeCount = min(
            max(newCount, 2),
            availableColors.count
        )

        if safeCount > selectedColorNames.count {
            addColorsUntilCount(safeCount)
        } else if safeCount < selectedColorNames.count {
            selectedColorNames = Array(selectedColorNames.prefix(safeCount))
        }

        saveSettings()
    }

    func resetToDefault() {
        selectedColorNames = GameSettings.defaultColors
        saveSettings()
    }

    private func addColorsUntilCount(_ targetCount: Int) {
        for color in availableColors {
            if selectedColorNames.count >= targetCount {
                return
            }

            if !selectedColorNames.contains(color.name) {
                selectedColorNames.append(color.name)
            }
        }
    }

    private func validateSelection() {
        selectedColorNames = selectedColorNames.filter { name in
            availableColors.contains { $0.name == name }
        }

        if selectedColorNames.count < 2 {
            selectedColorNames = GameSettings.defaultColors
        }
    }

    private func loadSettings() {
        let savedColors = UserDefaults.standard.stringArray(
            forKey: "selectedColorNames"
        )

        if let savedColors, savedColors.count >= 2 {
            selectedColorNames = savedColors
        } else {
            selectedColorNames = GameSettings.defaultColors
        }
    }

    private func saveSettings() {
        UserDefaults.standard.set(
            selectedColorNames,
            forKey: "selectedColorNames"
        )
    }
}
