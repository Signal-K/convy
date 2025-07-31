//
//  QuizQuestion.swift
//  Convo
//
//  Created by Liam Arbuckle on 2/7/2025.
//

import Foundation
import SwiftUI

private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))

struct QuizAnswer: Codable {
    let question: String
    let selectedAnswer: String
    let correctAnswer: String
    
    var isCorrect: Bool {
        selectedAnswer == correctAnswer
    }
}

struct QuizProgress: Codable {
    let quizTitle: String
    var answers: [QuizAnswer]
    var totalQuestions: Int

    var isCompleted: Bool {
        answers.count >= totalQuestions
    }

    var correctCount: Int {
        answers.filter { $0.isCorrect }.count
    }
}

class QuizProgressManager {
    static let shared = QuizProgressManager()
    private let keyPrefix = "quiz_progress_"

    func saveProgress(for quiz: Quiz, progress: QuizProgress) {
        let key = keyPrefix + quiz.title
        if let encoded = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func loadProgress(for quiz: Quiz) -> QuizProgress? {
        let key = keyPrefix + quiz.title
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode(QuizProgress.self, from: data) else {
            return nil
        }
        return decoded
    }

    func clearProgress(for quiz: Quiz) {
        let key = keyPrefix + quiz.title
        UserDefaults.standard.removeObject(forKey: key)
    }

    func resetAllProgress() {
        let defaults = UserDefaults.standard
        for key in defaults.dictionaryRepresentation().keys {
            if key.hasPrefix(keyPrefix) {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    func allProgress() -> [QuizProgress] {
        UserDefaults.standard.dictionaryRepresentation().compactMap { key, value in
            guard key.hasPrefix(keyPrefix),
                  let data = value as? Data,
                  let decoded = try? JSONDecoder().decode(QuizProgress.self, from: data)
            else { return nil }
            return decoded
        }
    }
}

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let answers: [String]
    let correctAnswer: String
//    let reasoning: String
//    let skillsGained: [(name: String, description: String)]
}

struct QuizView: View {
    let quiz: Quiz
    let questions: [QuizQuestion]
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var showNext = false
    @State private var isComplete = false
    @Environment(\.dismiss) private var dismiss

    @State private var progress: QuizProgress
    
    init(quiz: Quiz, questions: [QuizQuestion]) {
        self.quiz = quiz
        self.questions = questions
        
        // Load saved progress or create new save for the [selected] quiz
        if let existing = QuizProgressManager.shared.loadProgress(for: quiz) {
            _progress = State(initialValue: existing)
        } else {
            _progress = State(initialValue: QuizProgress(
                quizTitle: quiz.title,
                answers: [],
                totalQuestions: questions.count
            ))
        }
    }
    
    var body: some View {
        if isComplete {
            QuizResultView(score: progress.correctCount, total: questions.count) {
                dismiss()
            }
        } else {
            let currentQuestion = questions[currentQuestionIndex]

            VStack(spacing: 20) {
                Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                    .font(.headline)
                    .foregroundColor(.gray)

                Text(currentQuestion.question)
                    .font(.title3)
                    .padding()

                ForEach(currentQuestion.answers, id: \.self) { answer in
                    Button(action: {
                        selectedAnswer = answer
                        showNext = true

                        let isCorrect = (answer == currentQuestion.correctAnswer)
                        let quizAnswer = QuizAnswer(
                            question: currentQuestion.question,
                            selectedAnswer: answer,
                            correctAnswer: currentQuestion.correctAnswer
                        )

                        // Save answer to progress
                        progress.answers.append(quizAnswer)
                        QuizProgressManager.shared.saveProgress(for: quiz, progress: progress)
                    }) {
                        HStack {
                            Text(answer)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedAnswer == answer ? primary : Color.gray.opacity(0.4), lineWidth: 2)
                        )
                    }
                }

                if showNext {
                    Button(action: {
                        if currentQuestionIndex < questions.count - 1 {
                            currentQuestionIndex += 1
                            selectedAnswer = nil
                            showNext = false
                        } else {
                            isComplete = true
                        }
                    }) {
                        Text("Next")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(primary)
                            .cornerRadius(12)
                    }
                    .padding(.top, 10)
                }

                Spacer()
            }
            .padding()
        }
    }
}
