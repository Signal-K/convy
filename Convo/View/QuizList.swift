//
//  QuizList.swift
//  Convo
//
//  Created by Liam Arbuckle on 13/7/2025.
//

import SwiftUI

struct Quiz: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct QuizDetailView: View {
    let quiz: Quiz

    // Map each quiz title to a question set
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
                // Add more questions as needed
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
            .background(Color(.systemGroupedBackground))
        } else {
            QuizView(questions: quizQuestions)
                .navigationTitle(quiz.title)
        }
    }
}


struct QuizListView: View {
    let quizzes: [Quiz] = [
       Quiz(title: "Start a Conversation", description: "Practice icebreakers and small talk."),
       Quiz(title: "Express Yourself", description: "Work on tone, emotion, and clarity."),
       Quiz(title: "Handle Interruptions", description: "Train your assertiveness and flow."),
       Quiz(title: "Body Language Basics", description: "Non-verbal cues and posture awareness.")
   ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Available Quizzes")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                List(quizzes) { quiz in
                    let questionsAvailable = QuizDetailView(quiz: quiz).quizQuestions.isEmpty == false

                    NavigationLink(
                        destination: QuizDetailView(quiz: quiz),
                        label: {
                            VStack(alignment: .leading) {
                                Text(quiz.title)
                                    .font(.headline)
                                    .foregroundColor(questionsAvailable ? .primary : .gray)
                                Text(quiz.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    )
                    .disabled(!questionsAvailable)
                }
                .listStyle(InsetGroupedListStyle())
            }
            .padding(.horizontal)
        }
    }
}

struct QuizListView_Previews: PreviewProvider {
    static var previews: some View {
        QuizListView()
    }
}
