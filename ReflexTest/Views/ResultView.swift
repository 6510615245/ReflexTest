//
//  ResultView.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct ResultView: View {

    @EnvironmentObject var gameManager: GameManager

    let reactionTime: Double
    let onPlayAgain: () -> Void

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

                Text("RESULT 🎉")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
                    .padding(.top, 36)

                VStack(spacing: 12) {

                    Image(systemName: "stopwatch.fill")
                        .font(.system(size: 54))
                        .foregroundColor(.green)

                    Text(String(format: "%.3f s", reactionTime))
                        .font(.system(size: 54, weight: .black))
                        .foregroundColor(.green)

                    Text(resultMessage)
                        .font(.title2.bold())
                        .foregroundColor(.green)
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
                        value:
                            gameManager.bestTime == 0
                            ? "-"
                            : String(format: "%.3f s", gameManager.bestTime),
                        color: .yellow
                    )

                    ResultRow(
                        icon: "chart.bar.fill",
                        title: "Average Time",
                        value:
                            gameManager.averageTime == 0
                            ? "-"
                            : String(format: "%.3f s", gameManager.averageTime),
                        color: .blue
                    )

                    ResultRow(
                        icon: "bolt.fill",
                        title: "This Round",
                        value: String(format: "%.3f s", reactionTime),
                        color: .purple
                    )

                    ResultRow(
                        icon: "target",
                        title: "Total Attempts",
                        value: "\(gameManager.attempts)",
                        color: .green
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

                Spacer()
            }
        }
    }

    var resultMessage: String {

        if reactionTime < 0.25 {
            return "Great!"
        } else if reactionTime < 0.40 {
            return "Good!"
        } else {
            return "Keep Practicing!"
        }
    }
}

#Preview {
    ResultView(
        reactionTime: 0.248,
        onPlayAgain: {}
    )
    .environmentObject(GameManager())
}
