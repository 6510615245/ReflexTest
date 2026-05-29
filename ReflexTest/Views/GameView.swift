//
//  GameView.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct GameView: View {

    @EnvironmentObject var gameManager: GameManager
    @EnvironmentObject var settingsManager: SettingsManager
    @EnvironmentObject var navigationManager: AppNavigationManager

    @Environment(\.dismiss) private var dismiss

    @StateObject private var gameEngine = GameEngine()

    @State private var showFailResult = false
    @State private var failDelayToken = UUID()

    var body: some View {
        ZStack {

            if gameEngine.phase == .success || showFailResult {

                ResultView(
                    reactionTime: showFailResult ? nil : gameEngine.reactionTime,
                    missedTime: gameEngine.missedTargetTime,
                    didFail: showFailResult,

                    onPlayAgain: {

                        showFailResult = false
                        failDelayToken = UUID()

                        gameEngine.setupReadyState(
                            colors: settingsManager.selectedColors
                        )
                    },

                    onBackToHome: {
                        backToHome()
                    }
                )

            } else {

                gameContent
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {

            gameEngine.setupReadyState(
                colors: settingsManager.selectedColors
            )
        }
        .onDisappear {

            failDelayToken = UUID()

            gameEngine.stopRound()
        }
    }

    var gameContent: some View {

        ZStack {

            LinearGradient(
                colors: [
                    gameEngine.currentColor.color.opacity(0.9),
                    gameEngine.currentColor.color
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {

                Spacer()

                VStack(spacing: 10) {

                    Text(gameEngine.message)
                        .font(.system(size: 42, weight: .black))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    Text(gameEngine.subMessage)
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                }

                AnimatedColorCircle(
                    currentColor: gameEngine.currentColor,
                    animateRing: gameEngine.animateRing
                ) {

                    gameEngine.handleCircleTap(
                        colors: settingsManager.selectedColors
                    ) { reactionTime in

                        gameManager.saveReactionTime(reactionTime)

                    } onFail: {

                        let token = failDelayToken

                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 1.2
                        ) {

                            guard token == failDelayToken else {
                                return
                            }

                            showFailResult = true
                        }
                    }
                }

                if gameEngine.phase == .running {

                    Text("Target Color: \(gameEngine.targetColor.name)")
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 22)
                        .padding(.vertical, 12)
                        .background(Color.black.opacity(0.18))
                        .cornerRadius(16)
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }

    private func backToHome() {

        failDelayToken = UUID()

        showFailResult = false

        gameEngine.stopRound()

        navigationManager.selectedTab = 0

        dismiss()
    }
}

#Preview {

    NavigationStack {

        GameView()
            .environmentObject(GameManager())
            .environmentObject(SettingsManager())
            .environmentObject(AppNavigationManager())
    }
}
