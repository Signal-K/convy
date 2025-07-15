//
//  ProfileView.swift
//  Convo
//
//  Created by Liam Arbuckle on 2/7/2025.
//

import SwiftUI
import Supabase

struct UpdateProfileParams: Encodable {
    let username: String
    let fullName: String
    let website: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case fullName = "full_name"
        case website
    }
}

struct Profile: Decodable {
  let username: String?
  let fullName: String?
  let website: String?

  enum CodingKeys: String, CodingKey {
    case username
    case fullName = "full_name"
    case website
  }
}

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
                        
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                        }
                        
                        Button(action: updateProfileButtonTapped) {
                            Text("Update Profile")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(primary)
                                        .shadow(color: primary.opacity(0.3), radius: 6, x: 2, y: 2)
                                )
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    Task {
                        try? await supabase.auth.signOut()
                    }
                }) {
                    Text("Sign Out")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.red)
                                .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                        )
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .background(appBackground.ignoresSafeArea())
        }
        .task {
            await getInitialProfile()
        }
    }
    
    func getInitialProfile() async {
        do {
            let currentUser = try await supabase.auth.session.user
            let profile: Profile = try await supabase
                .from("profiles")
                .select()
                .eq("id", value: currentUser.id)
                .single()
                .execute()
                .value

            self.username = profile.username ?? ""
            self.fullName = profile.fullName ?? ""
            self.website = profile.website ?? ""
        } catch {
            debugPrint(error)
        }
    }
    
    func updateProfileButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                let currentUser = try await supabase.auth.session.user
                
                try await supabase
                    .from("profiles")
                    .update(
                        UpdateProfileParams(
                            username: username,
                            fullName: fullName,
                            website: website
                        )
                    )
                    .eq("id", value: currentUser.id)
                    .execute()
            } catch {
                debugPrint(error)
            }
        }
    }
}

#Preview {
    ProfileView()
}
