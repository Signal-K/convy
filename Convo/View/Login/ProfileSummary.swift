//
//  ProfileSummary.swift
//  Convo
//
//  Created by Liam Arbuckle on 5/7/2025.
//

import SwiftUI

private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))

struct ProfileSummaryView: View {
    @AppStorage("userName") private var name = ""
    @AppStorage("userUsername") private var username = ""
    @AppStorage("userSkillFocus") private var skill = ""
    @AppStorage("userAvatar") private var avatar = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("🎉 Welcome, \(name)!")
                .font(.largeTitle)
                .bold()

            Text("Username: @\(username)")
            Text("Skill Focus: \(skill)")
            Text("Avatar: \(avatar)")

            Spacer()
        }
        .padding()
        .navigationTitle("Your Profile")
    }
}
