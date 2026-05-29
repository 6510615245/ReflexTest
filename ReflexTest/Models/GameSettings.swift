//
//  GameSettings.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import Foundation

struct GameSettings {

    static let defaultColors = [
        "BLUE",
        "RED",
        "GREEN",
        "YELLOW"
    ]

    var selectedColors: [String]

    init(
        selectedColors: [String] = GameSettings.defaultColors
    ) {
        self.selectedColors = selectedColors
    }

    mutating func resetToDefault() {
        selectedColors = GameSettings.defaultColors
    }
}
