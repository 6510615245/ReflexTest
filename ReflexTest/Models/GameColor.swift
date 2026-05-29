//
//  GameColor.swift
//  ReflexTest
//
//  Created by Ploypan on 29/5/2569 BE.
//

import SwiftUI

struct GameColor: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let color: Color

    static func == (lhs: GameColor, rhs: GameColor) -> Bool {
        lhs.name == rhs.name
    }
}
