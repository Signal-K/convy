//
//  ProfileView.swift
//  Convo
//
//  Created by Liam Arbuckle on 2/7/2025.
//

import SwiftUI

struct ProfileView: View {
    @State var username = ""
    @State var fullName = ""
    @State var website = ""
    @State var isLoading = false
    
    private let surface = Color.white
    private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
    private let accent = Color(#colorLiteral(red: 0.55, green: 0.79, blue: 0.87, alpha: 1))
    private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Your Profile")
                            .font(.largeTitle.bold())
                            .foregroundColor(primary)
                        
                        Group {
                            ConvoInputField(title: "Username", text: $username)
                            ConvoInputField(title: "Full Name", text: $fullName)
                            ConvoInputField(title: "Website", text: $website)
                        }
                    }
                }
            }
        }
    }
}
