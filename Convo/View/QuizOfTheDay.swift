//
//  QuizOfTheDay.swift
//  Convo
//
//  Created by Liam Arbuckle on 13/8/2025.
//

import SwiftUI

final class QuizOfTheDayManager: ObservableObject {
    static let shared = QuizOfTheDayManager()
    private let storedDateKey = "qotd_stored_date"
    private let storedTitleKey = "qotd_stored_title"
    private let bonusAwardedDateKey = "qotd_bonus_awarded_date"
    private let goldKey = "goldPieces"

    func currentQuiz(from quizzes: [Quiz]) -> Quiz? {
        guard !quizzes.isEmpty else { return nil }
        let todayKey = Self.dayKey(Date())
        let defaults = UserDefaults.standard
        let storedDay = defaults.string(forKey: storedDateKey)
        let storedTitle = defaults.string(forKey: storedTitleKey)

        if storedDay == todayKey, let title = storedTitle, let match = quizzes.first(where: { $0.title == title }) {
            return match
        } else {
            let pick = quizzes.randomElement()!
            defaults.set(todayKey, forKey: storedDateKey)
            defaults.set(pick.title, forKey: storedTitleKey)
            return pick
        }
    }

    func isQuizOfTheDay(_ quiz: Quiz, in quizzes: [Quiz]) -> Bool {
        guard let q = currentQuiz(from: quizzes) else { return false }
        return q.title == quiz.title
    }

    func awardBonusIfEligible(for quiz: Quiz, in quizzes: [Quiz]) {
        guard isQuizOfTheDay(quiz, in: quizzes) else { return }
        let defaults = UserDefaults.standard
        let todayKey = Self.dayKey(Date())
        if defaults.string(forKey: bonusAwardedDateKey) != todayKey {
            let current = defaults.integer(forKey: goldKey)
            defaults.set(current + 2, forKey: goldKey)
            defaults.set(todayKey, forKey: bonusAwardedDateKey)
        }
    }

    private static func dayKey(_ date: Date) -> String {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return "\(comps.year ?? 0)-\(comps.month ?? 0)-\(comps.day ?? 0)"
    }
}

struct QuizOfTheDayView: View {
    let quizzes: [Quiz]
    let onStart: (Quiz) -> Void

    @ObservedObject private var theme = ThemeManager.shared
    @State private var featured: Quiz?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quiz of the Day")
                .font(.title2.bold())
                .foregroundColor(theme.primary)

            if let q = featured {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Text("⭐")
                        Text(q.title)
                            .font(.headline)
                            .foregroundColor(theme.primary)
                        Spacer()
                        Text("+2 Gold")
                            .font(.caption.bold())
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.yellow.opacity(0.25))
                            .cornerRadius(8)
                    }
                    Text(q.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Button {
                        QuizProgressManager.shared.clearProgress(for: q)
                        onStart(q)
                    } label: {
                        Text("Start Now")
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(theme.primary)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(theme.surface)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.yellow.opacity(0.6), lineWidth: 2)
                        )
                        .shadow(color: .white.opacity(0.7), radius: 6, x: -4, y: -4)
                        .shadow(color: .black.opacity(0.08), radius: 6, x: 4, y: 4)
                )
            }
        }
        .onAppear {
            featured = QuizOfTheDayManager.shared.currentQuiz(from: quizzes)
        }
    }
}
