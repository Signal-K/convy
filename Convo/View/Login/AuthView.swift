//
//  AuthView.swift
//  Convi
//
//  Created by Liam Arbuckle on 23/5/2025.
//

import SwiftUI

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var result: Result<Void, Error>?
    
    // Theme colours
    private let background = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)) // snow storm
    private let surface = Color.white
    private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1)) // stronger nord blue
    private let accent = Color(#colorLiteral(red: 0.55, green: 0.79, blue: 0.87, alpha: 1)) // nord frost
    private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))
    private let textPrimary = Color.black
    private let textSecondary = Color.gray.opacity(0.7)
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 32) {
                    Spacer().frame(height: 60)
                    
                    Image("app_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .padding(20)
                        .background(
                            surface
                                .shadow(color: .white.opacity(0.8), radius: 6, x: -6, y: -6)
                                .shadow(color: .black.opacity(0.1), radius: 6, x: 6, y: 6)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Text("Sign in to Convi")
                        .font(.title)
                        .bold()
                        .foregroundColor(primary)
                    
                    VStack(spacing: 20) {
                        CustomTextField(placeholder: "Email", text: $email, isSecure: false)
                        CustomTextField(placeholder: "Password", text: $password, isSecure: true)
                    }
                    
                    if let result {
                        switch result {
                        case .success:
                            Text("Signed in successfully")
                                .foregroundColor(.green)
                        case .failure(let error):
                            Text(error.localizedDescription)
                                .foregroundColor(.red)
                        }
                    }
                    
                    VStack(spacing: 16) {
                        Button(action: signInButtonTapped) {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(primary)
                                        .shadow(color: primary.opacity(0.3), radius: 8, x: 4, y: 4)
                                )
                        }
                        
                        Button(action: signUpButtonTapped) {
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .foregroundColor(primary)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(surface)
                                        .shadow(color: .white, radius: 6, x: -4, y: -4)
                                        .shadow(color: .gray.opacity(0.3), radius: 6, x: 4, y: 4)
                                )
                        }
                    }
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: primary))
                            .padding()
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, geometry.safeAreaInsets.top)
            }
            .background(background.ignoresSafeArea())
        }
    }
    
    func signInButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await supabase.auth.signIn(email: email, password: password)
                result = .success(())
            } catch {
                result = .failure(error)
            }
        }
    }

    func signUpButtonTapped() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                try await supabase.auth.signUp(email: email, password: password)
                result = .success(())
            } catch {
                result = .failure(error)
            }
        }
    }
}

#Preview {
    AuthView()
}
