//
//  GameView.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct GameView: View {

    @EnvironmentObject var gameManager: GameManager

    @State private var targetColor = GameColor(name: "BLUE", color: .blue)
    @State private var currentColor = GameColor(name: "READY", color: .gray)

    @State private var message = "READY?"
    @State private var subMessage = "Tap the circle to start"

    @State private var targetAppearTime = Date()
    @State private var missedTargetTime: Double = 0
    @State private var currentDisplayDuration: Double = 0

    @State private var reactionTime: Double = 0
    @State private var showResult = false
    @State private var isFailed = false
    @State private var isRoundActive = false
    @State private var animateRing = false
    @State private var waitingForReadyTap = true

    @State private var roundToken = UUID()

    var body: some View {
        ZStack {
            if showResult {
                ResultView(
                    reactionTime: reactionTime,
                    onPlayAgain: {
                        setupReadyState()
                    }
                )
            } else {
                gameContent
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            setupReadyState()
        }
        .onDisappear {
            isRoundActive = false
        }
    }

    var gameContent: some View {
        ZStack {
            LinearGradient(
                colors: [
                    currentColor.color.opacity(0.9),
                    currentColor.color
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer()

                VStack(spacing: 10) {
                    Text(message)
                        .font(.system(size: 42, weight: .black))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Text(subMessage)
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                }

                tappableCircle

                Text("Target Color: \(targetColor.name)")
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 12)
                    .background(Color.black.opacity(0.18))
                    .cornerRadius(16)

                Text(String(format: "Missed Target Time: %.2f s", missedTargetTime))
                    .font(.subheadline.bold())
                    .foregroundColor(.white.opacity(0.8))

                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }

    var tappableCircle: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.07))
                .frame(width: 280, height: 280)

            Circle()
                .stroke(Color.white.opacity(0.28), lineWidth: 10)
                .frame(width: 280, height: 280)
                .scaleEffect(animateRing ? 1.08 : 0.92)
                .opacity(animateRing ? 1.0 : 0.55)
                .animation(
                    .easeInOut(duration: 0.9)
                    .repeatForever(autoreverses: true),
                    value: animateRing
                )

            Circle()
                .fill(currentColor.color.opacity(0.95))
                .frame(width: 210, height: 210)
                .shadow(
                    color: currentColor.color.opacity(0.65),
                    radius: 26
                )

            Text(currentColor.name)
                .font(.system(size: 34, weight: .black))
                .foregroundColor(.white)
        }
        .frame(width: 280, height: 280)
        .contentShape(Circle())
        .onTapGesture {
            handleCircleTap()
        }
    }

    func setupReadyState() {
        roundToken = UUID()

        waitingForReadyTap = true
        showResult = false
        isFailed = false
        isRoundActive = false

        missedTargetTime = 0
        reactionTime = 0
        currentDisplayDuration = 0

        targetColor = gameManager.randomTargetColor()
        currentColor = GameColor(name: "READY", color: .gray)

        message = "READY?"
        subMessage = "Tap the circle to start"

        animateRing = true
    }

    func startNewRound() {
        roundToken = UUID()

        waitingForReadyTap = false
        showResult = false
        isFailed = false
        isRoundActive = true

        missedTargetTime = 0
        reactionTime = 0
        currentDisplayDuration = 0

        targetColor = gameManager.randomTargetColor()
        currentColor = GameColor(name: "READY", color: .gray)

        message = "WATCH CLOSELY"
        subMessage = "Tap when the circle becomes \(targetColor.name)"

        let token = roundToken
        let firstDelay = Double.random(in: 1.0...2.0)

        DispatchQueue.main.asyncAfter(deadline: .now() + firstDelay) {
            showNextColor(token: token)
        }
    }

    func showNextColor(token: UUID) {
        guard isRoundActive, !showResult, !isFailed, token == roundToken else {
            return
        }

        let nextColor = gameManager.randomDisplayColor()
        let duration: Double

        if isTargetColor(nextColor) {

            duration = Double.random(in: 0.6...1.2)

        } else {

            duration = Double.random(in: 1.2...2.5)
        }

        currentColor = nextColor
        currentDisplayDuration = duration

        if isTargetColor(nextColor) {
            targetAppearTime = Date()
            message = "TAP NOW!"
            subMessage = "\(targetColor.name) appears for \(String(format: "%.1f", duration)) seconds"
        } else {
            message = "WAIT..."
            subMessage = "\(nextColor.name) is not the target color"
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            finishCurrentColor(token: token, color: nextColor, duration: duration)
        }
    }

    func finishCurrentColor(token: UUID, color: GameColor, duration: Double) {
        guard isRoundActive, !showResult, !isFailed, token == roundToken else {
            return
        }

        if isTargetColor(color) {
            missedTargetTime += duration
        }

        showNextColor(token: token)
    }

    func handleCircleTap() {
        if waitingForReadyTap {
            startNewRound()
            return
        }

        guard isRoundActive, !showResult else {
            return
        }

        if isTargetColor(currentColor) {
            let currentReactionTime = Date().timeIntervalSince(targetAppearTime)
            reactionTime = missedTargetTime + currentReactionTime

            gameManager.saveReactionTime(reactionTime)

            isRoundActive = false
            showResult = true
        } else {
            failRound()
        }
    }

    func failRound() {
        isFailed = true
        isRoundActive = false

        currentColor = GameColor(name: "FAILED", color: .red)
        message = "FAILED ❌"
        subMessage = "You tapped the wrong color"

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            setupReadyState()
        }
    }

    func isTargetColor(_ color: GameColor) -> Bool {
        color.name == targetColor.name
    }
}

#Preview {
    NavigationStack {
        GameView()
            .environmentObject(GameManager())
    }
}
