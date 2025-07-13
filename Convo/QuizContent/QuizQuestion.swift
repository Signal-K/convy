//
//  QuizQuestion.swift
//  Convo
//
//  Created by Liam Arbuckle on 13/7/2025.
//

import SwiftUI

// MARK: - Data Model
struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let answers: [String]
    let correctAnswer: String
}

// MARK: - Quiz View
struct QuizView: View {
    let questions: [QuizQuestion]
    
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var showNext = false  // ✅ Fix: Should be @State, not @state
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(questions[currentQuestionIndex].question)
                .font(.title3)
                .padding()
            
            ForEach(questions[currentQuestionIndex].answers, id: \.self) { answer in  // ✅ Fix: add `answer in`
                Button(action: {
                    selectedAnswer = answer
                    showNext = true // ✅ Fix: use `=`, not `:`
                }) {
                    HStack {
                        Text(answer)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selectedAnswer == answer ? Color.blue : Color.gray.opacity(0.5), lineWidth: 2)
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
                        // TODO: Handle end of quiz state
                    }
                }) {
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 10)
            }
            
            Spacer()
        }
        .padding()
    }
}
