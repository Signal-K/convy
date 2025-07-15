//
//  QuizProgress.swift
//  Convo
//
//  Created by Liam Arbuckle on 4/7/2025.
//

import Foundation

struct QuizAnswer: Codable {
    let question: String
    let selectedAnswer: String
    let isCorrect: Bool
}

struct QuizProgress: Codable {
    let quizTitle: String
    var answers: [QuizAnswer]
    var isCompleted: Bool {
        answers.count >= totalQuestions
    }
    
    var totalQuestions: Int
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
}
