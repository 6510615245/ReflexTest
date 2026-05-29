//
//  StatRow.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct StatRow: View {

    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {

        HStack {

            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title3)
                .frame(width: 34)

            Text(title)
                .font(.headline)
                .foregroundColor(.black.opacity(0.75))

            Spacer()

            Text(value)
                .font(.headline.bold())
                .foregroundColor(.black)
        }
    }
}

#Preview {
    StatRow(
        icon: "chart.bar.fill",
        title: "Average",
        value: "0.278 s",
        color: .blue
    )
}
