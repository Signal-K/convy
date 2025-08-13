//
//  BottomNavigation.swift
//  Convo
//
//  Created by Liam Arbuckle on 6/7/2025.
//

import SwiftUI

struct BottomNavigation: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        TabView {
            QuizListView()
                .background(themeManager.appBackground.ignoresSafeArea())
                .tabItem {
                    Label("Quizzes", systemImage: "list.bullet.rectangle.portrait")
                }

            SkillProgressView()
                .background(themeManager.appBackground.ignoresSafeArea())
                .tabItem {
                    Label("Skills", systemImage: "figure.walk")
                }
            
            ShopView()
                .background(themeManager.appBackground.ignoresSafeArea())
                .tabItem {
                    Label("Shop", systemImage: "cart")
                }
            
            UserSetupView()
                .background(themeManager.appBackground.ignoresSafeArea())
                .tabItem {
                    Label("Setup", systemImage: "person.crop.circle")
                }
        }
        .accentColor(themeManager.primary) // Matches selected theme
        .onAppear {
            // Apply theme to the UITabBar globally
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(themeManager.surface) // Tab bar background
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(themeManager.primary)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(themeManager.primary)]
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    BottomNavigation()
        .environmentObject(ThemeManager.shared)
}
