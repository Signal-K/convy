//
//  BottomNavigation.swift
//  Convo
//
//  Created by Liam Arbuckle on 6/7/2025.
//

import SwiftUI

struct BottomNavigation: View {
    var body: some View {
        TabView {
            QuizListView()
                .tabItem {
                    Label("Quizzes", systemImage: "list.bullet.rectangle.portrait")
                }

            SkillProgressView()
                .tabItem {
                    Label("Skills", systemImage: "figure.walk")
                }
//
//            ProfileView()
//                .tabItem {
//                    Label("Profile", systemImage: "person.crop.circle")
//                }
            
            UserSetupView()
                .tabItem {
                    Label("Setup", systemImage: "person.crop.circle")
                }
        }
        .accentColor(.blue) // Customize to match Convo brand
    }
}

#Preview {
    BottomNavigation()
}
