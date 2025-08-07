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
    
    private let themeKey = "activeTheme"
    
    private init() {
        let storedThemeName = UserDefaults.standard.string(forKey: themeKey) ?? "Default"
        let defaultTheme = allThemes.first(where: { $0.name == storedThemeName }) ?? allThemes[0]
        self.primary = defaultTheme.primary
        self.appBackground = defaultTheme.appBackground
        self.surface = defaultTheme.surface
    }
    
    func apply(theme: Theme) {
        self.primary = theme.primary
        self.appBackground = theme.appBackground
        self.surface = theme.surface
        UserDefaults.standard.set(theme.name, forKey: themeKey)
    }
}


struct Theme {
    let name: String
    let primary: Color
    let appBackground: Color
    let surface: Color
}


let defaultTheme = Theme(
    name: "Default",
    primary: Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1)),
    appBackground: Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)),
    surface: Color.white
)

let darkTheme = Theme(
    name: "Dark",
    primary: Color.white,
    appBackground: Color.black,
    surface: Color.gray.opacity(0.2)
)

let bubblegumTheme = Theme(
    name: "Bubblegum",
    primary: Color.pink,
    appBackground: Color(#colorLiteral(red: 1.0, green: 0.8, blue: 0.9, alpha: 1)),
    surface: Color(#colorLiteral(red: 1, green: 0.7, blue: 0.8, alpha: 1))
)

let neonTheme = Theme(
    name: "Neon",
    primary: Color.green,
    appBackground: Color.black,
    surface: Color(#colorLiteral(red: 0.1, green: 0.1, blue: 0.1, alpha: 1))
)

let allThemes = [defaultTheme, darkTheme, bubblegumTheme, neonTheme]
