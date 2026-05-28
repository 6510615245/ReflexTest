//
//  ResultRow.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct ResultRow: View {

    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {

        HStack {

            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 42)

            Text(title)
                .font(.headline)
                .foregroundColor(.white)

            Spacer()

            Text(value)
                .font(.headline.bold())
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ResultRow(
        icon: "crown.fill",
        title: "Best Time",
        value: "0.215 s",
        color: .yellow
    )
}
