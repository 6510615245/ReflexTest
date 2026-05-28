//
//  ContentView.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Text("REFLEX TEST")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)

                Text("Tap as fast as you can when the screen turns green.")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                VStack(spacing: 12) {
                    Text("Best Time: -")
                    Text("Average Time: -")
                    Text("Played: 0 times")
                }
                .font(.title3)
                .foregroundColor(.white)

                Button {
                    print("Start tapped")
                } label: {
                    Text("START")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(width: 220, height: 56)
                        .background(Color.green)
                        .cornerRadius(18)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
