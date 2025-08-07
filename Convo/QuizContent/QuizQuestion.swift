//
//  QuizQuestion.swift
//  Convo
//
//  Created by Liam Arbuckle on 2/7/2025.
//

import Foundation
import SwiftUI

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
    var completedDate: Date?

    var isCompleted: Bool {
        answers.count >= totalQuestions
    }

    var correctCount: Int {
        answers.filter { $0.isCorrect }.count
    }
}

class QuizProgressManager: ObservableObject {
    static let shared = QuizProgressManager()
    private let keyPrefix = "quiz_progress_"

    @Published var progressVersion = UUID()

    func saveProgress(for quiz: Quiz, progress: QuizProgress) {
        let key = keyPrefix + quiz.title
        if let encoded = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
        progressVersion = UUID()
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
        progressVersion = UUID()
    }

    func resetAllProgress() {
        let defaults = UserDefaults.standard
        for key in defaults.dictionaryRepresentation().keys {
            if key.hasPrefix("quiz_progress_") {
                defaults.removeObject(forKey: key)
            }
        }
        progressVersion = UUID()
    }
}

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let answers: [String]
    let correctAnswer: String
    let mainSkill: String
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
    @State private var shuffledAnswers: [String] = []
    
    // Use ThemeManager instead of UserColorScheme
    @ObservedObject private var theme = ThemeManager.shared
    
    init(quiz: Quiz, questions: [QuizQuestion]) {
        self.quiz = quiz
        self.questions = questions
        
        if let existing = QuizProgressManager.shared.loadProgress(for: quiz) {
            _progress = State(initialValue: existing)
        } else {
            _progress = State(initialValue: QuizProgress(
                quizTitle: quiz.title,
                answers: [],
                totalQuestions: questions.count
            ))
        }
        _shuffledAnswers = State(initialValue: [])
    }
    
    var body: some View {
        Group {
            if isComplete {
                QuizResultView(
                    score: progress.correctCount,
                    total: questions.count,
                    incorrectAnswers: progress.answers.filter { !$0.isCorrect },
                    onDismiss: {
                        dismiss()
                    }
                )
            } else {
                let currentQuestion = questions[currentQuestionIndex]
                
                VStack(spacing: 20) {
                    Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Text(currentQuestion.question)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(theme.surface)
                        )
                        .shadow(color: .white.opacity(0.8), radius: 4, x: -2, y: -2)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
                        .padding(.horizontal)
                    
                    VStack(spacing: 16) {
                        ForEach(shuffledAnswers, id: \.self) { answer in
                            answerButton(for: answer, currentQuestion: currentQuestion)
                        }
                    }
                    .padding(.horizontal)
                    
                    if showNext {
                        Button(action: {
                            if currentQuestionIndex < questions.count - 1 {
                                currentQuestionIndex += 1
                                selectedAnswer = nil
                                showNext = false
                                shuffleCurrentAnswers()
                            } else {
                                isComplete = true
                            }
                        }) {
                            Text(currentQuestionIndex < questions.count - 1 ? "Next Question" : "Finish Quiz")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(theme.primary)
                                        .shadow(color: theme.primary.opacity(0.3), radius: 5, x: 2, y: 2)
                                )
                        }
                        .padding([.horizontal, .top])
                    }
                    
                    Spacer()
                }
                .padding(.vertical)
                .background(theme.appBackground.ignoresSafeArea())
                .onAppear {
                    shuffleCurrentAnswers()
                }
            }
        }
    }
    
    private func shuffleCurrentAnswers() {
        guard currentQuestionIndex < questions.count else { return }
        shuffledAnswers = questions[currentQuestionIndex].answers.shuffled()
    }
    
    private func answerButton(for answer: String, currentQuestion: QuizQuestion) -> some View {
        // Capture values to avoid closure retention issues
        let currentAnswer = answer
        let question = currentQuestion
        
        return AnswerButton(
            answer: currentAnswer,
            currentQuestion: question,
            selectedAnswer: selectedAnswer,
            showNext: showNext,
            primary: theme.primary,
            surface: theme.surface,
            border: Color.gray.opacity(0.3) // Add a border color since ThemeManager doesn't have one
        ) { [quiz] in  // Explicitly capture quiz
            // Guard against multiple taps and ensure we're still on the right question
            guard !showNext,
                  currentQuestionIndex < questions.count,
                  questions[currentQuestionIndex].id == question.id else {
                return
            }
            
            selectedAnswer = currentAnswer
            showNext = true
            
            let quizAnswer = QuizAnswer(
                question: question.question,
                selectedAnswer: currentAnswer,
                correctAnswer: question.correctAnswer
            )
            
            // Create a new progress instance to avoid mutation issues
            var newProgress = progress
            newProgress.answers.append(quizAnswer)
            progress = newProgress
            
            // Save progress on main thread
            DispatchQueue.main.async {
                QuizProgressManager.shared.saveProgress(for: quiz, progress: newProgress)
            }
        }
        .disabled(showNext)
    }
}

struct AnswerButton: View {
    let answer: String
    let currentQuestion: QuizQuestion
    let selectedAnswer: String?
    let showNext: Bool
    
    let primary: Color
    let surface: Color
    let border: Color
    
    let action: () -> Void
    
    var body: some View {
        let imageName = systemImageName(for: answer, currentQuestion: currentQuestion, showNext: showNext, selectedAnswer: selectedAnswer)
        
        Button(action: action) {
            HStack {
                Text(answer)
                    .foregroundColor(.primary)
                    .fontWeight(.medium)
                Spacer()
                if !imageName.isEmpty {
                    Image(systemName: imageName)
                        .foregroundColor(imageName == "checkmark.circle.fill" ? .green : .red)
                }
            }
            .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(surface)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            selectedAnswer == answer ? primary : border,
                            lineWidth: selectedAnswer == answer ? 2.5 : 1
                        )
                )
        )
        .shadow(color: .white.opacity(0.7), radius: 3, x: -2, y: -2)
        .shadow(color: .black.opacity(0.1), radius: 3, x: 2, y: 2)
    }
    
    private func systemImageName(for answer: String, currentQuestion: QuizQuestion, showNext: Bool, selectedAnswer: String?) -> String {
        if !showNext {
            return ""
        } else if answer == currentQuestion.correctAnswer {
            return "checkmark.circle.fill"
        } else if answer == selectedAnswer {
            return "xmark.circle.fill"
        } else {
            return ""
        }
    }
}
