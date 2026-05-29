//
//  GameManager.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import Foundation
import Combine

class GameManager: ObservableObject {

    @Published var bestTime: Double = 0
    @Published var averageTime: Double = 0
    @Published var attempts: Int = 0

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
