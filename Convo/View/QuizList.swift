//
//  QuizList.swift
//  Convo
//
//  Created by Liam Arbuckle on 8/7/2025.
//

import SwiftUI

// MARK: - Theme
private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))

// MARK: - Model
struct Quiz: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

// MARK: - Quiz Detail View
struct QuizDetailView: View {
    let quiz: Quiz

    var quizQuestions: [QuizQuestion] {
        switch quiz.title {
        case "Start a Conversation":
            return [
                QuizQuestion(
                    question: "You see a broken vase and Liam looking uneasy. How should you begin the conversation?",
                    answers: [
                        "A. “Liam, why did you break this vase?”",
                        "B. “I see the vase is broken. Can you tell me what happened when you’re ready?”",
                        "C. “You need to clean this up right now!”",
                        "D. “That was very careless of you.”"
                    ],
                    correctAnswer: "B. “I see the vase is broken. Can you tell me what happened when you’re ready?”"
                ),
                QuizQuestion(
                    question: "Liam looks at you but doesn’t speak yet. How can you open the conversation gently?",
                    answers: [
                        "A. “It’s okay, Liam. Take your time and tell me what happened when you’re ready.”",
                        "B. “Why won’t you just tell me what you did? You can’t hide from me.”",
                        "C. “I’m really upset that you didn’t tell me right away; you need to be honest.”",
                        "D. “If you don’t explain now, you’ll be in trouble later.”"
                    ],
                    correctAnswer: "A. “It’s okay, Liam. Take your time and tell me what happened when you’re ready.”"
                )
            ]
        default:
            return []
        }
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
                // Show review of answers
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
                    }
                    .padding()
                }
                .background(appBackground)
                .navigationTitle(quiz.title)
            } else {
                // Show interactive quiz
                QuizView(quiz: quiz, questions: quizQuestions)
                    .navigationTitle(quiz.title)
            }
        }
    }
}

// MARK: - Quiz List View
struct QuizListView: View {
    let quizzes: [Quiz] = [
        Quiz(title: "Start a Conversation", description: "Practice icebreakers and small talk."),
        Quiz(title: "Express Yourself", description: "Work on tone, emotion, and clarity."),
        Quiz(title: "Handle Interruptions", description: "Train your assertiveness and flow."),
        Quiz(title: "Body Language Basics", description: "Non-verbal cues and posture awareness.")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Available Quizzes")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(primary)
                        .padding(.top)

                    ForEach(quizzes) { quiz in
                        let questionsAvailable = !QuizDetailView(quiz: quiz).quizQuestions.isEmpty
                        let progress = QuizProgressManager.shared.loadProgress(for: quiz)
                        let completed = progress?.isCompleted == true

                        NavigationLink(destination: QuizDetailView(quiz: quiz)) {
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text(quiz.title)
                                        .font(.headline)
                                        .foregroundColor(completed ? .green : (questionsAvailable ? primary : .gray))

                                    if completed {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                            .imageScale(.small)
                                            .padding(.leading, 4)
                                    }
                                }

                                Text(quiz.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(surface)
                                    .shadow(color: .white.opacity(0.7), radius: 6, x: -4, y: -4)
                                    .shadow(color: .black.opacity(0.08), radius: 6, x: 4, y: 4)
                            )
                        }
                        .disabled(!questionsAvailable)
                    }
                }
                .padding(24)
            }
            .background(appBackground.ignoresSafeArea())
        }
    }
}

#Preview {
    QuizListView()
}
