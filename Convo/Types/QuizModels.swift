import Foundation

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
    var completedDate: Date? = nil

    var isCompleted: Bool {
        answers.count >= totalQuestions
    }

    var correctCount: Int {
        answers.filter { $0.isCorrect }.count
    }
}

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let answers: [String]
    let correctAnswer: String
}
