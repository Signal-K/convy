//
//  QuizList.swift
//  Convo
//
//  Created by Liam Arbuckle on 8/7/2025.
//

import SwiftUI

private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))

struct Quiz: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct QuizDetailView: View {
    let quiz: Quiz

    var quizQuestions: [QuizQuestion] {
        QuizContent.all[quiz.title] ?? []
    }

    var body: some View {
        if quizQuestions.isEmpty {
            VStack(spacing: 16) {
                Text("This quiz doesn’t have any questions yet.")
                    .font(.title3)
                    .padding()
                    .multilineTextAlignment(.center)
                Text("Please check back later.")
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(quiz.title)
            .background(appBackground)
        } else {
            let progress = QuizProgressManager.shared.loadProgress(for: quiz)

            if let progress, progress.isCompleted {
                // Calculate stats grouped by skill
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
                            .foregroundColor(primary)
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
                                    .fill(surface)
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
                    }
                    .padding()
                }
                .background(appBackground)
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
    
    @AppStorage("preferredSkill") private var preferredSkill: String?
    
    // Returns dictionary: skill -> (wrong, total) counts based on progress
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
                if !answer.isCorrect {
                    current.wrong += 1
                }
                result[skill] = current
            }
        }
        
        return result
    }

    // Calculate weakness % for skill (0 to 1), or nil if no data
    private func weaknessPercentage(for skill: String, skillStats: [String: (wrong: Int, total: Int)]) -> Double? {
        guard let stats = skillStats[skill], stats.total > 0 else { return nil }
        return Double(stats.wrong) / Double(stats.total)
    }

    // Get all skills and their counts in a quiz
    private func dominantSkills(for quiz: Quiz) -> [String: Int] {
        let questions = QuizContent.all[quiz.title] ?? []
        let grouped = Dictionary(grouping: questions, by: { $0.mainSkill })
        return grouped.mapValues { $0.count }
    }

    // Check if quiz contains given skill
    private func quizContainsSkill(_ quiz: Quiz, skill: String) -> Bool {
        let questions = QuizContent.all[quiz.title] ?? []
        return questions.contains(where: { $0.mainSkill == skill })
    }


    // Now matches exactly the keys in QuizContent.all
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

    var incompleteQuizzes: [Quiz] {
        let skillStats = skillWeakness()

        // If preferred skill set and some incomplete quizzes have it
        if let preferred = preferredSkill,
           quizzes.contains(where: { quizContainsSkill($0, skill: preferred) && !(QuizProgressManager.shared.loadProgress(for: $0)?.isCompleted ?? false) }) {

            // Quizzes with preferred skill first
            let preferredSkillQuizzes = quizzes.filter {
                quizContainsSkill($0, skill: preferred) && !(QuizProgressManager.shared.loadProgress(for: $0)?.isCompleted ?? false)
            }

            // Other incomplete quizzes without preferred skill
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
            // No preferred skill or no incomplete quizzes with preferred skill; sort all incomplete by weakness descending
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
                    Text("Available Quizzes")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(primary)
                        .padding(.top)

                    // Incomplete Quizzes
                    if !incompleteQuizzes.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(incompleteQuizzes) { quiz in
                                quizRow(for: quiz)
                            }
                        }
                    }

                    // Completed Quizzes
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

                    // Reset All Progress
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
                }
                .padding(24)
            }
            .background(appBackground.ignoresSafeArea())
            .navigationTitle("Quizzes")
        }
    }

    @ViewBuilder
    private func quizRow(for quiz: Quiz) -> some View {
        let _ = progressManager.progressVersion

        let questions = QuizContent.all[quiz.title] ?? []
        let progress = QuizProgressManager.shared.loadProgress(for: quiz)
        let isCompleted = progress?.isCompleted ?? false
        let hasQuestions = !questions.isEmpty

        let titleColor: Color = {
            if isCompleted { return .green }
            else if hasQuestions { return primary }
            else { return .gray }
        }()

        let completedDateText: String? = {
            if let date = progress?.completedDate, isCompleted {
                return dateFormatter.string(from: date)
            }
            return nil
        }()

        // Calculate dominant skill for this quiz
        let dominantSkill: String? = {
            guard !questions.isEmpty else { return nil }
            let skillCounts = Dictionary(grouping: questions, by: { $0.mainSkill })
                .mapValues { $0.count }
            return skillCounts.max(by: { $0.value < $1.value })?.key
        }()

        let labelView = VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(quiz.title)
                    .font(.headline)
                    .foregroundColor(titleColor)

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
                .fill(surface)
                .shadow(color: .white.opacity(0.7), radius: 6, x: -4, y: -4)
                .shadow(color: .black.opacity(0.08), radius: 6, x: 4, y: 4)
        )

        NavigationLink(
            destination: QuizDetailView(quiz: quiz),
            label: {
                labelView
            }
        )
        .disabled(!hasQuestions)
    }
}

#Preview {
    QuizListView()
}
