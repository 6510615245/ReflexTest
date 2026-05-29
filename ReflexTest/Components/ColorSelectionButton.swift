//
//  ColorSelectionButton.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct ColorSelectionButton: View {

    let gameColor: GameColor
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 10) {
                Circle()
                    .fill(gameColor.color)
                    .frame(width: 28, height: 28)

                Text(gameColor.name)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 104)
            .background(isSelected ? Color.blue.opacity(0.10) : Color(.systemGray6))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ColorSelectionButton(
        gameColor: GameColor(name: "BLUE", color: .blue),
        isSelected: true,
        onTap: {}
    )
}
