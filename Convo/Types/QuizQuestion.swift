import Foundation

public struct QuizQuestion: Identifiable {
    public let id = UUID()
    public let question: String
    public let answers: [String]
    public let correctAnswer: String
    // public let reasoning: String
    // public let skillsGained: [(name: String, description: String)]
}
