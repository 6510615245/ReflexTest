//
//  GameManager.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import Foundation
import Combine
import SwiftUI

struct GameColor: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let color: Color
}

class GameManager: ObservableObject {

    @Published var bestTime: Double = 0
    @Published var averageTime: Double = 0
    @Published var attempts: Int = 0

    @Published var enabledColors: [GameColor] = [
        GameColor(name: "BLUE", color: .blue),
        GameColor(name: "ORANGE", color: .orange),
        GameColor(name: "GREEN", color: .green),
        GameColor(name: "PURPLE", color: .purple)
    ]

    func randomTargetColor() -> GameColor {
        enabledColors.randomElement() ?? GameColor(name: "BLUE", color: .blue)
    }

    func randomDisplayColor() -> GameColor {
        enabledColors.randomElement() ?? GameColor(name: "BLUE", color: .blue)
    }

    func saveReactionTime(_ time: Double) {
        attempts += 1

        if bestTime == 0 || time < bestTime {
            bestTime = time
        }

        averageTime =
        ((averageTime * Double(attempts - 1)) + time)
        / Double(attempts)
    }
}
