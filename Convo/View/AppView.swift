import SwiftUI

struct AppView: View {
    @State private var isAuthenticated = false
    @AppStorage("userName") private var name = ""

    var body: some View {
        Group {
            if name.isEmpty {
//                UserSetupView() // new user onboarding
                BottomNavigation()
            } else if isAuthenticated {
                BottomNavigation() // signed in + profile complete
            } else {
                BottomNavigation() // fallback: maybe change this back to AuthView later
            }
        }
        .task {
            for await state in supabase.auth.authStateChanges {
                if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                    isAuthenticated = state.session != nil
                }
            }
        }
    }
}

#Preview {
    AppView()
}
