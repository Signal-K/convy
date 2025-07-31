//
//  ThemeManager.swift
//  Convo
//
//  Created by Liam Arbuckle on 31/7/2025.
//

import SwiftUI
import Combine

final class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var primary: Color
    @Published var appBackground: Color
    @Published var surface: Color
    
    private init() {
        // Default theme colors
        self.primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
        self.appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
        self.surface = Color.white
    }
    
    func apply(theme: Theme) {
        self.primary = theme.primary
        self.appBackground = theme.appBackground
        self.surface = theme.surface
    }
}

struct Theme {
    let name: String
    let primary: Color
    let appBackground: Color
    let surface: Color
}
