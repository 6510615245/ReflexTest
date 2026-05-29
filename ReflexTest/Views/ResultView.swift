//
//  ResultView.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct ResultView: View {

    @EnvironmentObject var gameManager: GameManager

    let reactionTime: Double?
    let missedTime: Double
    let didFail: Bool
    let onPlayAgain: () -> Void
    let onBackToHome: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.06, blue: 0.08),
                    Color(red: 0.10, green: 0.11, blue: 0.15)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 26) {
                Text(didFail ? "FAILED" : "RESULT 🎉")
                    .font(.system(size: 32, weight: .black))
                    .foregroundColor(.white)
                    .padding(.top, 36)

                VStack(spacing: 12) {
                    Image(systemName: didFail ? "xmark.circle.fill" : "stopwatch.fill")
                        .font(.system(size: 58))
                        .foregroundColor(didFail ? .red : .green)

                    Text(didFail ? "You Missed!" : formattedReactionTime)
                        .font(.system(size: didFail ? 38 : 54, weight: .black))
                        .foregroundColor(didFail ? .red : .green)

                    Text(didFail ? "Focus on the target color" : resultMessage)
                        .font(.title3.bold())
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 34)
                .background(Color.white.opacity(0.07))
                .cornerRadius(24)
                .padding(.horizontal, 34)

                VStack(spacing: 22) {
                    ResultRow(
                        icon: "crown.fill",
                        title: "Best Time",
                        value: gameManager.bestTime == 0
                        ? "-"
                        : String(format: "%.3f s", gameManager.bestTime),
                        color: .yellow
                    )

                    ResultRow(
                        icon: "bolt.fill",
                        title: "This Round",
                        value: didFail ? "FAIL" : formattedReactionTime,
                        color: didFail ? .red : .purple
                    )

                    ResultRow(
                        icon: "timer",
                        title: "Missed Time",
                        value: String(format: "%.3f s", missedTime),
                        color: .blue
                    )
                }
                .padding(24)
                .background(Color.white.opacity(0.07))
                .cornerRadius(22)
                .padding(.horizontal, 34)

                Button(action: onPlayAgain) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("PLAY AGAIN")
                    }
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 62)
                    .background(Color.white.opacity(0.14))
                    .cornerRadius(18)
                }
                .padding(.horizontal, 34)

                Button(action: onBackToHome) {
                    HStack {
                        Image(systemName: "house.fill")
                        Text("BACK TO HOME")
                    }
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 62)
                    .background(Color.blue)
                    .cornerRadius(18)
                }
                .padding(.horizontal, 34)

                Spacer()
            }
        }
    }

    var formattedReactionTime: String {
        guard let reactionTime else {
            return "-"
        }

        return String(format: "%.3f s", reactionTime)
    }

    var resultMessage: String {
        guard let reactionTime else {
            return "No result"
        }

        if reactionTime < 0.25 {
            return "Excellent!"
        } else if reactionTime < 0.60 {
            return "Great!"
        } else if reactionTime < 1.20 {
            return "Good!"
        } else {
            return "Keep Practicing!"
        }
    }
}

#Preview {
    ResultView(
        reactionTime: 0.531,
        missedTime: 0.800,
        didFail: false,
        onPlayAgain: {},
        onBackToHome: {}
    )
    .environmentObject(GameManager())
}
