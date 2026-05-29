//
//  GameEngine.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import Foundation
import Combine
import SwiftUI

class GameEngine: ObservableObject {

    @Published var phase: GamePhase = .ready

    @Published var targetColor = GameColor(name: "BLUE", color: .blue)
    @Published var currentColor = GameColor(name: "READY", color: .gray)

    @Published var message = "READY?"
    @Published var subMessage = "Tap the circle to start"

    @Published var missedTargetTime: Double = 0
    @Published var reactionTime: Double = 0
    @Published var animateRing = false

    private var roundToken = UUID()
    private var isRoundActive = false
    private var targetAppearTime = Date()

    func setupReadyState(colors: [GameColor]) {
        roundToken = UUID()
        isRoundActive = false

        phase = .ready
        missedTargetTime = 0
        reactionTime = 0

        targetColor = randomColor(from: colors)
        currentColor = GameColor(name: "READY", color: .gray)

        message = "READY?"
        subMessage = "Tap the circle to start"
        animateRing = true
    }

    func startNewRound(colors: [GameColor]) {
        roundToken = UUID()
        isRoundActive = true

        phase = .running
        missedTargetTime = 0
        reactionTime = 0

        targetColor = randomColor(from: colors)
        currentColor = GameColor(name: "READY", color: .gray)

        message = "WATCH CLOSELY"
        subMessage = "Tap when the circle becomes \(targetColor.name)"

        let token = roundToken
        let firstDelay = Double.random(in: 1.0...2.0)

        DispatchQueue.main.asyncAfter(deadline: .now() + firstDelay) {
            self.showNextColor(colors: colors, token: token)
        }
    }

    private func showNextColor(colors: [GameColor], token: UUID) {
        guard isRoundActive, phase == .running, token == roundToken else {
            return
        }

        let nextColor = randomColor(from: colors)
        currentColor = nextColor

        let duration = displayDuration(for: nextColor)

        if isTargetColor(nextColor) {
            targetAppearTime = Date()
            message = "TAP NOW!"
            subMessage = "\(targetColor.name) appears briefly"
        } else {
            message = "WAIT..."
            subMessage = "\(nextColor.name) is not the target color"
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.finishCurrentColor(
                colors: colors,
                token: token,
                color: nextColor,
                duration: duration
            )
        }
    }

    private func finishCurrentColor(
        colors: [GameColor],
        token: UUID,
        color: GameColor,
        duration: Double
    ) {
        guard isRoundActive, phase == .running, token == roundToken else {
            return
        }

        if isTargetColor(color) {
            missedTargetTime += duration
        }

        showNextColor(colors: colors, token: token)
    }

    func handleCircleTap(
        colors: [GameColor],
        onSuccess: (Double) -> Void,
        onFail: () -> Void
    ) {
        if phase == .ready {
            startNewRound(colors: colors)
            return
        }

        guard phase == .running else {
            return
        }

        if isTargetColor(currentColor) {
            let currentReactionTime = Date().timeIntervalSince(targetAppearTime)
            reactionTime = missedTargetTime + currentReactionTime

            isRoundActive = false
            phase = .success

            onSuccess(reactionTime)
        } else {
            failRound()
            onFail()
        }
    }

    func failRound() {
        isRoundActive = false
        phase = .failed

        currentColor = GameColor(name: "FAILED", color: .red)
        message = "FAILED"
        subMessage = "You tapped the wrong color"
    }

    func stopRound() {
        isRoundActive = false
        roundToken = UUID()
    }

    private func randomColor(from colors: [GameColor]) -> GameColor {
        colors.randomElement() ?? GameColor(name: "BLUE", color: .blue)
    }

    private func isTargetColor(_ color: GameColor) -> Bool {
        color.name == targetColor.name
    }

    private func displayDuration(for color: GameColor) -> Double {
        if isTargetColor(color) {
            return Double.random(in: 0.6...1.2)
        } else {
            return Double.random(in: 1.2...2.5)
        }
    }
}
