//
//  HomeView.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var gameManager: GameManager

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    .white,
                    Color(.systemGray6)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {

                Spacer()

                VStack(spacing: 8) {

                    Text("REFLEX TEST ⚡️")
                        .font(.system(size: 38,
                                      weight: .black))

                    Text("Test your reaction time!")
                        .font(.headline)
                        .foregroundColor(.gray)
                }

                VStack(spacing: 20) {

                    VStack(spacing: 18) {

                        HStack(spacing: 18) {

                            Image(systemName: "clock.fill")
                                .font(.system(size: 42))
                                .foregroundColor(.blue)

                            VStack(alignment: .leading,
                                   spacing: 4) {

                                Text("Best Time")
                                    .font(.headline)
                                    .foregroundColor(.gray)

                                HStack(alignment: .lastTextBaseline,
                                       spacing: 4) {

                                    Text(
                                        gameManager.bestTime == 0
                                        ? "-"
                                        : String(
                                            format: "%.3f",
                                            gameManager.bestTime
                                        )
                                    )
                                    .font(.system(size: 40,
                                                  weight: .bold))

                                    Text("s")
                                        .font(.headline)
                                }
                            }

                            Spacer()

                            Text("👑")
                                .font(.title)
                        }

                        Divider()

                        StatRow(
                            icon: "chart.bar.fill",
                            title: "Average",
                            value:
                                gameManager.averageTime == 0
                                ? "-"
                                : String(
                                    format: "%.3f s",
                                    gameManager.averageTime
                                ),
                            color: .blue
                        )

                        StatRow(
                            icon: "target",
                            title: "Attempts",
                            value: "\(gameManager.attempts)",
                            color: .green
                        )
                    }
                }
                .padding(28)
                .background(.white)
                .cornerRadius(28)
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 14,
                    x: 0,
                    y: 8
                )
                .padding(.horizontal, 30)

                NavigationLink {

                    GameView()

                } label: {

                    HStack(spacing: 12) {

                        Image(systemName: "play.fill")

                        Text("START")
                    }
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 68)
                    .background(
                        LinearGradient(
                            colors: [
                                .blue,
                                Color(
                                    red: 0,
                                    green: 0.45,
                                    blue: 1
                                )
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(18)
                }
                .padding(.horizontal, 30)

                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(GameManager())
    }
}
