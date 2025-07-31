//
//  ProgressOverview.swift
//  Convo
//
//  Created by Liam Arbuckle on 31/7/2025.
//

import SwiftUI

private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))

struct ProgressOverviewView: View {
    @AppStorage("quizCompletionDates") private var completionDatesData: Data = Data()
    
    @State private var completedQuizzes: [QuizProgress] = []
    @State private var totalCorrectAnswers: Int = 0
    @State private var quizCompletionDates: [String: Date] = [:] // [quizTitle: Date]

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Progress")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(primary)

            HStack(spacing: 20) {
                statCard(title: "Completed Quizzes", value: "\(completedQuizzes.count)")
                statCard(title: "Correct Answers", value: "\(totalCorrectAnswers)")
                statCard(title: "Gold Pieces", value: "\(completedQuizzes.count)")
            }
            .padding()

            List {
                ForEach(completedQuizzes, id: \.quizTitle) { progress in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(progress.quizTitle)
                                .font(.headline)
                            if let date = quizCompletionDates[progress.quizTitle] {
                                Text("Completed: \(formatted(date))")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        Text("\(progress.correctCount)/\(progress.totalQuestions)")
                            .foregroundColor(progress.correctCount == progress.totalQuestions ? .green : .primary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .background(appBackground)
        .onAppear {
            loadData()
        }
    }

    private func statCard(title: String, value: String) -> some View {
        VStack {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(primary)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(surface)
        .cornerRadius(12)
        .shadow(radius: 2)
    }

    private func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    private func loadData() {
        // Load quiz progress
        let all = QuizProgressManager.shared.allProgress()
        let completed = all.filter { $0.isCompleted }
        completedQuizzes = completed
        totalCorrectAnswers = completed.reduce(0) { $0 + $1.correctCount }

        // Load stored completion dates
        if let decoded = try? JSONDecoder().decode([String: Date].self, from: completionDatesData) {
            quizCompletionDates = decoded
        }

        // Update with new completions
        var updated = quizCompletionDates
        for quiz in completed {
            if updated[quiz.quizTitle] == nil {
                updated[quiz.quizTitle] = Date()
            }
        }

        // Save if changes made
        if updated != quizCompletionDates,
           let encoded = try? JSONEncoder().encode(updated) {
            completionDatesData = encoded
            quizCompletionDates = updated
        }
    }
}

#Preview("Progress Overview Demo") {
    // Simulate stored progress in UserDefaults for preview
    let sampleQuiz1 = Quiz(title: "Sample A", description: "")
    let sampleQuiz2 = Quiz(title: "Sample B", description: "")

    let sampleProgress1 = QuizProgress(
        quizTitle: sampleQuiz1.title,
        answers: [
            QuizAnswer(question: "Q1", selectedAnswer: "A", correctAnswer: "A"),
            QuizAnswer(question: "Q2", selectedAnswer: "B", correctAnswer: "C"),
            QuizAnswer(question: "Q3", selectedAnswer: "C", correctAnswer: "C"),
        ],
        totalQuestions: 3
    )

    let sampleProgress2 = QuizProgress(
        quizTitle: sampleQuiz2.title,
        answers: [
            QuizAnswer(question: "Q1", selectedAnswer: "A", correctAnswer: "A"),
            QuizAnswer(question: "Q2", selectedAnswer: "B", correctAnswer: "B"),
        ],
        totalQuestions: 2
    )

    // Store previews in UserDefaults (will persist between runs unless reset)
    QuizProgressManager.shared.saveProgress(for: sampleQuiz1, progress: sampleProgress1)
    QuizProgressManager.shared.saveProgress(for: sampleQuiz2, progress: sampleProgress2)

    return ProgressOverviewView()
}
