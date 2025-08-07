//
//  UserProgress.swift
//  Convo
//
//  Created by Liam Arbuckle on 18/6/2025.
//

import SwiftUI

struct SkillProgressView: View {
    @State private var showStreakView = false
    
    // Inject your theme manager for colors
    @EnvironmentObject var themeManager: ThemeManager

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

    // MARK: - Pull questions & skills from QuizContent
    var allAnswers: [(skill: String, correct: Bool)] {
        var result: [(String, Bool)] = []

        for progress in allProgress {
            guard let questions = QuizContent.all[progress.quizTitle] else { continue }

            for answer in progress.answers {
                if let matchedQuestion = questions.first(where: { $0.question == answer.question }) {
                    result.append((matchedQuestion.mainSkill, answer.isCorrect))
                }
            }
        }

        return result
    }

    var skillsWithStats: [(skill: String, correct: Int, total: Int)] {
        let grouped = Dictionary(grouping: allAnswers, by: { $0.skill })

        return grouped.map { skill, results in
            let correct = results.filter { $0.correct }.count
            return (skill, correct, results.count)
        }.sorted { $0.skill < $1.skill }
    }

    var body: some View {
        VStack(spacing: 32) {
            Text("Your Skills")
                .font(.largeTitle.bold())
                .foregroundColor(themeManager.primary)
                .padding(.top)

            VStack(spacing: 16) {
                if skillsWithStats.isEmpty {
                    Text("No skills earned yet.\nTry completing some quiz questions!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ForEach(skillsWithStats, id: \.skill) { skill, correct, total in
                        let progress = Double(correct) / Double(total)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(skill) (\(correct)/\(total))")
                                .font(.body.bold())
                                .foregroundColor(themeManager.primary)

                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 8)

                                RoundedRectangle(cornerRadius: 10)
                                    .fill(themeManager.primary)
                                    .frame(width: CGFloat(progress) * UIScreen.main.bounds.width * 0.7, height: 8)
                                    .animation(.easeInOut(duration: 0.3), value: progress)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(themeManager.surface)
                                .shadow(color: .white.opacity(0.6), radius: 4, x: -2, y: -2)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
                        )
                    }
                }
            }

            Spacer()

            VStack(spacing: 12) {
                Text("Level \(level)")
                    .font(.headline)
                    .foregroundColor(themeManager.primary)

                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(themeManager.surface)
                        .frame(height: 20)
                        .shadow(color: .white.opacity(0.6), radius: 4, x: -2, y: -2)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(themeManager.primary)
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
                    .background(themeManager.primary)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
            }
            .padding(.top)

            Spacer()
        }
        .padding(.horizontal, 24)
        .background(themeManager.appBackground.ignoresSafeArea())
        .sheet(isPresented: $showStreakView) {
            StreakCalendarView()
        }
    }
}
