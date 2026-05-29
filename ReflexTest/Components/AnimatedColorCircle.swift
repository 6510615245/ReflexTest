//
//  AnimatedColorCircle.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct AnimatedColorCircle: View {

    let currentColor: GameColor
    let animateRing: Bool
    let onTap: () -> Void

    var body: some View {
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
            onTap()
        }
    }
}

#Preview {
    AnimatedColorCircle(
        currentColor: GameColor(name: "BLUE", color: .blue),
        animateRing: true,
        onTap: {}
    )
}
