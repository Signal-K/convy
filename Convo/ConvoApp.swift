//
//  ConvoApp.swift
//  Convo
//
//  Created by Liam Arbuckle on 17/6/2025.
//

import SwiftUI

@main
struct ConvoApp: App {
    @StateObject private var themeManager = ThemeManager.shared

    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(themeManager)
        }
    }
}

#Preview("App Root Preview") {
    AppView()
        .environmentObject(ThemeManager.shared)
}
