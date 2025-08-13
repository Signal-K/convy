//
//  QuizList.swift
//  Convo
//
//  Created by Liam Arbuckle on 8/7/2025.
//

import SwiftUI

struct Quiz: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct QuizDetailView: View {
    let quiz: Quiz
    @ObservedObject private var theme = ThemeManager.shared

    var quizQuestions: [QuizQuestion] {
        QuizContent.all[quiz.title] ?? []
    }

    var body: some View {
        if quizQuestions.isEmpty {
            VStack(spacing: 16) {
                Text("This quiz doesn't have any questions yet.")
                    .font(.title3)
                    .padding()
                    .multilineTextAlignment(.center)
                Text("Please check back later.")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(quiz.title)
            .background(theme.appBackground)
        } else {
            let progress = QuizProgressManager.shared.loadProgress(for: quiz)

            if let progress, progress.isCompleted {
                let answersBySkill = Dictionary(grouping: progress.answers) { answer in
                    quizQuestions.first(where: { $0.question == answer.question })?.mainSkill ?? "Unknown Skill"
                }

                let skillStats: [(skill: String, correct: Int, wrong: Int)] = answersBySkill.map { (skill, answers) in
                    let correctCount = answers.filter { $0.isCorrect }.count
                    let wrongCount = answers.count - correctCount
                    return (skill, correctCount, wrongCount)
                }
                .sorted { $0.skill < $1.skill }

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("You completed this quiz 🎉")
                            .font(.title2)
                            .bold()
                            .foregroundColor(theme.primary)
                            .padding(.top)

                        ForEach(progress.answers, id: \.question) { answer in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(answer.question)
                                    .font(.subheadline)
                                    .bold()

                                if let question = quizQuestions.first(where: { $0.question == answer.question }) {
                                    Text("Skill: \(question.mainSkill)")
                                        .font(.caption)
                                        .italic()
                                        .foregroundColor(.secondary)
                                }

                                Text("Your Answer: \(answer.selectedAnswer)")
                                    .foregroundColor(answer.isCorrect ? .green : .red)

                                if !answer.isCorrect {
                                    if let question = quizQuestions.first(where: { $0.question == answer.question }) {
                                        Text("Correct Answer: \(question.correctAnswer)")
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(theme.surface)
                                    .shadow(color: .white.opacity(0.6), radius: 4, x: -2, y: -2)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
                            )
                        }

                        Divider()
                            .padding(.vertical)

                        Text("Summary by Skill")
                            .font(.headline)
                            .padding(.bottom, 4)

                        ForEach(skillStats, id: \.skill) { stat in
                            HStack {
                                Text(stat.skill)
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text("✅ \(stat.correct)")
                                    .foregroundColor(.green)

                                Text("❌ \(stat.wrong)")
                                    .foregroundColor(.red)
                            }
                        }

                        Button("Redo Quiz") {
                            QuizProgressManager.shared.clearProgress(for: quiz)
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let rootNav = windowScene.windows.first?.rootViewController as? UINavigationController {
                                let newView = QuizView(quiz: quiz, questions: quizQuestions)
                                let hosting = UIHostingController(rootView: newView)
                                rootNav.pushViewController(hosting, animated: true)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(theme.primary)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding()
                }
                .background(theme.appBackground)
                .navigationTitle(quiz.title)
            } else {
                QuizView(quiz: quiz, questions: quizQuestions)
                    .navigationTitle(quiz.title)
            }
        }
    }
}

struct QuizListView: View {
    @StateObject private var progressManager = QuizProgressManager.shared
    @State private var resetConfirmationShown = false
    @ObservedObject private var theme = ThemeManager.shared

    @AppStorage("preferredSkill") private var preferredSkill: String?

    @State private var pushDailyQuiz: Quiz?
    @State private var pushDetailQuiz: Quiz?

    let quizzes: [Quiz] = [
        Quiz(title: "Start a Conversation", description: "Practice icebreakers and small talk."),
        Quiz(title: "Turning an acquaintance to a friend", description: "Learn how to go from stranger to friend."),
        Quiz(title: "Deepening Intimacy", description: "Build emotional connection and presence."),
        Quiz(title: "Dealing with Awkward Moments", description: "Gracefully handle unexpected or uncomfortable situations.")
    ]

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    private func skillWeakness() -> [String: (wrong: Int, total: Int)] {
        var result = [String: (wrong: Int, total: Int)]()
        for quiz in quizzes {
            guard let progress = QuizProgressManager.shared.loadProgress(for: quiz) else { continue }
            let questions = QuizContent.all[quiz.title] ?? []
            for answer in progress.answers {
                guard let question = questions.first(where: { $0.question == answer.question }) else { continue }
                let skill = question.mainSkill
                var current = result[skill] ?? (0, 0)
                current.total += 1
                if !answer.isCorrect { current.wrong += 1 }
                result[skill] = current
            }
        }
        return result
    }

    private func weaknessPercentage(for skill: String, skillStats: [String: (wrong: Int, total: Int)]) -> Double? {
        guard let stats = skillStats[skill], stats.total > 0 else { return nil }
        return Double(stats.wrong) / Double(stats.total)
    }

    private func dominantSkills(for quiz: Quiz) -> [String: Int] {
        let questions = QuizContent.all[quiz.title] ?? []
        let grouped = Dictionary(grouping: questions, by: { $0.mainSkill })
        return grouped.mapValues { $0.count }
    }

    private func quizContainsSkill(_ quiz: Quiz, skill: String) -> Bool {
        let questions = QuizContent.all[quiz.title] ?? []
        return questions.contains(where: { $0.mainSkill == skill })
    }

    var incompleteQuizzes: [Quiz] {
        let skillStats = skillWeakness()
        if let preferred = preferredSkill,
           quizzes.contains(where: { quizContainsSkill($0, skill: preferred) && !(QuizProgressManager.shared.loadProgress(for: $0)?.isCompleted ?? false) }) {
            let preferredSkillQuizzes = quizzes.filter {
                quizContainsSkill($0, skill: preferred) && !(QuizProgressManager.shared.loadProgress(for: $0)?.isCompleted ?? false)
            }
            let otherQuizzes = quizzes.filter {
                !quizContainsSkill($0, skill: preferred) && !(QuizProgressManager.shared.loadProgress(for: $0)?.isCompleted ?? false)
            }
            let orderedOthers = otherQuizzes.sorted { q1, q2 in
                func quizWeaknessValue(_ quiz: Quiz) -> Double {
                    let domSkills = dominantSkills(for: quiz)
                    let maxWeakness = domSkills.compactMap { (skill, _) in
                        weaknessPercentage(for: skill, skillStats: skillStats)
                    }.max() ?? 0
                    return maxWeakness
                }
                return quizWeaknessValue(q1) > quizWeaknessValue(q2)
            }
            return preferredSkillQuizzes + orderedOthers
        } else {
            return quizzes.filter { !(QuizProgressManager.shared.loadProgress(for: $0)?.isCompleted ?? false) }
                .sorted { q1, q2 in
                    func quizWeaknessValue(_ quiz: Quiz) -> Double {
                        let domSkills = dominantSkills(for: quiz)
                        let maxWeakness = domSkills.compactMap { (skill, _) in
                            weaknessPercentage(for: skill, skillStats: skillStats)
                        }.max() ?? 0
                        return maxWeakness
                    }
                    return quizWeaknessValue(q1) > quizWeaknessValue(q2)
                }
        }
    }

    var completedQuizzes: [Quiz] {
        quizzes.filter { quiz in
            QuizProgressManager.shared.loadProgress(for: quiz)?.isCompleted ?? false
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    QuizOfTheDayView(quizzes: quizzes) { q in
                        QuizProgressManager.shared.clearProgress(for: q)
                        pushDailyQuiz = q
                    }

                    Text("Available Quizzes")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(theme.primary)
                        .padding(.top)

                    if !incompleteQuizzes.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(incompleteQuizzes) { quiz in
                                quizRow(for: quiz)
                            }
                        }
                    }

                    if !completedQuizzes.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Archived Quizzes")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.gray)
                                .padding(.top, 32)

                            ForEach(completedQuizzes) { quiz in
                                quizRow(for: quiz)
                            }
                        }
                    }

                    Button(role: .destructive) {
                        resetConfirmationShown = true
                    } label: {
                        Text("Reset All Progress")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(12)
                    }
                    .padding(.top, 20)
                    .confirmationDialog("Are you sure you want to reset all progress?", isPresented: $resetConfirmationShown) {
                        Button("Reset All", role: .destructive) {
                            QuizProgressManager.shared.resetAllProgress()
                        }
                        Button("Cancel", role: .cancel) {}
                    }

                    // Fixed NavigationLinks with ViewBuilder returning some View
                    NavigationLink(
                        destination: Group {
                            if let quiz = pushDailyQuiz {
                                QuizView(quiz: quiz, questions: QuizContent.all[quiz.title] ?? [])
                            } else {
                                EmptyView()
                            }
                        },
                        isActive: Binding(
                            get: { pushDailyQuiz != nil },
                            set: { isActive in if !isActive { pushDailyQuiz = nil } }
                        )
                    ) { EmptyView() }
                    .hidden()

                    NavigationLink(
                        destination: Group {
                            if let quiz = pushDetailQuiz {
                                QuizDetailView(quiz: quiz)
                            } else {
                                EmptyView()
                            }
                        },
                        isActive: Binding(
                            get: { pushDetailQuiz != nil },
                            set: { isActive in if !isActive { pushDetailQuiz = nil } }
                        )
                    ) { EmptyView() }
                    .hidden()
                }
                .padding(24)
            }
            .background(theme.appBackground.ignoresSafeArea())
            .navigationTitle("Quizzes")
            .toolbarBackground(theme.surface, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    @ViewBuilder
    private func quizRow(for quiz: Quiz) -> some View {
        let _ = progressManager.progressVersion

        let questions = QuizContent.all[quiz.title] ?? []
        let progress = QuizProgressManager.shared.loadProgress(for: quiz)
        let isCompleted = progress?.isCompleted ?? false
        let hasQuestions = !questions.isEmpty
        let isDaily = QuizOfTheDayManager.shared.isQuizOfTheDay(quiz, in: quizzes)

        let titleColor: Color = {
            if isCompleted { return .green }
            else if hasQuestions { return theme.primary }
            else { return .gray }
        }()

        let completedDateText: String? = {
            if let date = progress?.completedDate, isCompleted {
                return dateFormatter.string(from: date)
            }
            return nil
        }()

        let dominantSkill: String? = {
            guard !questions.isEmpty else { return nil }
            let skillCounts = Dictionary(grouping: questions, by: { $0.mainSkill })
                .mapValues { $0.count }
            return skillCounts.max(by: { $0.value < $1.value })?.key
        }()

        let labelView = VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Text(quiz.title)
                    .font(.headline)
                    .foregroundColor(titleColor)
                if isDaily {
                    Text("Today")
                        .font(.caption2.bold())
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.yellow.opacity(0.25))
                        .cornerRadius(6)
                }
                if isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .imageScale(.small)
                        .padding(.leading, 4)
                }
            }

            Text(quiz.description)
                .font(.subheadline)
                .foregroundColor(.gray)

            if let dominantSkill {
                Text("Dominant Skill: \(dominantSkill)")
                    .font(.caption)
                    .italic()
                    .foregroundColor(.secondary)
            }

            if let completedText = completedDateText {
                Text("Completed: \(completedText)")
                    .font(.caption)
                    .foregroundColor(.yellow)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(theme.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isDaily ? Color.yellow.opacity(0.6) : Color.clear, lineWidth: 2)
                )
                .shadow(color: .white.opacity(0.7), radius: 6, x: -4, y: -4)
                .shadow(color: .black.opacity(0.08), radius: 6, x: 4, y: 4)
        )

        Button {
            if isDaily {
                QuizProgressManager.shared.clearProgress(for: quiz)
                pushDailyQuiz = quiz
            } else {
                pushDetailQuiz = quiz
            }
        } label: {
            labelView
        }
        .disabled(!hasQuestions)
    }
}

#Preview {
    QuizListView()
}
