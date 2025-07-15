//
//  UserProgress.swift
//  Convo
//
//  Created by Liam Arbuckle on 18/6/2025.
//

import SwiftUI

private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))

struct SkillProgressView: View {
    @State private var showStreakView = false

    let earnedSkills = [
        "💬 Small Talk Starter",
        "👂 Active Listener",
        "😌 Comfortable Pauser",
        "🤝 Confident Opener",
        "😎 Eye Contact Master"
    ]
    
    var allProgress: [QuizProgress] {
        UserDefaults.standard.dictionaryRepresentation().compactMap { key, value in
            guard key.starts(with: "quiz_progress_"),
                  let data = value as? Data,
                  let decoded = try? JSONDecoder().decode(QuizProgress.self, from: data) else {
                return nil
            }
            return decoded
        }
    }
    
    var totalCorrectAnswers: Int {
        allProgress.reduce(0) { $0 + $1.correctCount }
    }
    
    var level: Int {
        (totalCorrectAnswers / 5) + 1
    }
    
    var progressPercent: Double {
        Double(totalCorrectAnswers % 5) / 5.0
    }
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Your Skills")
                .font(.largeTitle.bold())
                .foregroundColor(primary)
                .padding(.top)
            
            VStack(spacing: 16) {
                ForEach(earnedSkills, id: \.self) { skill in
                    HStack {
                        Text(skill)
                            .font(.body)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(surface)
                            .shadow(color: .white.opacity(0.6), radius: 4, x: -2, y: -2)
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
                    )
                }
            }
            
            Spacer()

            VStack(spacing: 12) {
                Text("Level \(level)")
                    .font(.headline)
                    .foregroundColor(primary)
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(surface)
                        .frame(height: 20)
                        .shadow(color: .white.opacity(0.6), radius: 4, x: -2, y: -2)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(primary)
                        .frame(width: CGFloat(progressPercent) * UIScreen.main.bounds.width * 0.8, height: 20)
                        .animation(.easeInOut(duration: 0.4), value: progressPercent)
                }

                Text("\(totalCorrectAnswers % 5) / 5 XP to next level")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 24)

            Button(action: {
                showStreakView = true
            }) {
                Text("View Streak Calendar")
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(primary)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
            }
            .padding(.top)

            Spacer()
        }
        .padding(.horizontal, 24)
        .background(appBackground.ignoresSafeArea())
        .sheet(isPresented: $showStreakView) {
            StreakCalendarView()
        }
    }
}
