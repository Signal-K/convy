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

//            PracticeMissionsView()
//                .tabItem {
//                    Label("Practice", systemImage: "figure.walk")
//                }
//
//            ReflectionLogView()
//                .tabItem {
//                    Label("Reflections", systemImage: "book.closed")
//                }
//
//            ProfileView()
//                .tabItem {
//                    Label("Profile", systemImage: "person.crop.circle")
//                }
        }
        .accentColor(.blue) // Customize to match Convo brand
    }
}

#Preview {
    BottomNavigation()
}
