import SwiftUI

private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))

struct UserSetupView: View {
    @AppStorage("username") private var name = ""
    @AppStorage("userUsername") private var username = ""
    @AppStorage("userSkillFocus") private var selectedSkill = ""
    @AppStorage("userAvatar") private var avatar = ""

    @State private var showCompleted = false

    let skillOptions = [
        "Confidence in Conversation",
        "Small Talk Mastery",
        "Active Listening",
        "Empathy and Tone",
        "Handling Awkward Moments",
        "Professional Communication"
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    Text("Set Up Your Profile")
                        .font(.largeTitle.bold())
                        .foregroundColor(primary)
                        .padding(.top, 40)

                    NeumorphicInput(title: "Your Name", text: $name)
                    NeumorphicInput(title: "Username", text: $username)
                    NeumorphicInput(title: "Choose an Emoji Avatar", text: $avatar)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Skill Focus")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Menu {
                            ForEach(skillOptions, id: \.self) { skill in
                                Button {
                                    selectedSkill = skill
                                } label: {
                                    Text(skill)
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedSkill.isEmpty ? "Select a skill..." : selectedSkill)
                                    .foregroundColor(selectedSkill.isEmpty ? .gray : .primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(surface)
                                    .shadow(color: .white.opacity(0.7), radius: 4, x: -2, y: -2)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
                            )
                        }
                    }

                    Button(action: {
                        showCompleted = true
                    }) {
                        Text("Save and Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(primary)
                                    .shadow(color: primary.opacity(0.3), radius: 6, x: 3, y: 3)
                            )
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 24)
            }
            .background(appBackground.ignoresSafeArea())
            .navigationDestination(isPresented: $showCompleted) {
                ProfileSummaryView()
            }
        }
    }
}
