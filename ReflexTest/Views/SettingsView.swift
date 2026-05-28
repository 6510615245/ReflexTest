//
//  SettingsView.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct SettingsView: View {

    var body: some View {

        ZStack {

            Color(.systemGray6)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                Image(systemName: "gearshape.fill")
                    .font(.system(size: 70))
                    .foregroundColor(.blue)

                Text("Settings")
                    .font(.largeTitle.bold())

                Text("More features coming soon")
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    SettingsView()
}
