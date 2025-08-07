import SwiftUI

private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))

struct QuizResultView: View {
    let score: Int
    let total: Int
    let incorrectAnswers: [QuizAnswer]
    let onDismiss: () -> Void
    
    var percentage: Double {
        Double(score) / Double(score + incorrectAnswers.count)
    }
    
    var feedbackEmoji: String {
        switch percentage {
        case 0.9...1.0: return "🌟"
        case 0.7..<0.9: return "👏"
        case 0.4..<0.7: return "😊"
        default: return "🤔"
        }
    }
    
    var feedbackText: String {
        switch percentage {
        case 0.9...1.0: return "Amazing work!"
        case 0.7..<0.9: return "Great job!"
        case 0.4..<0.7: return "You're learning!"
        default: return "Keep practicing!"
        }
    }
    
    @State private var scale: CGFloat = 0.7
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Quiz Complete")
                    .font(.title)
                    .bold()
                    .foregroundColor(primary)
                
                Text(feedbackEmoji)
                    .font(.system(size: 80))
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.5)) {
                            scale = 1.2
                        }
                    }
                
                Text(feedbackText)
                    .font(.title)
                    .bold()
                    .foregroundColor(primary)
                
                Text("You got \(score) out of \(score + incorrectAnswers.count) correct")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                if !incorrectAnswers.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Questions to Review")
                            .font(.headline)
                            .foregroundColor(.red)
                        
                        ForEach(incorrectAnswers, id: \.question) { answer in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(answer.question)
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(primary)
                                
                                Text("Your Answer: \(answer.selectedAnswer)")
                                    .foregroundColor(.red)
                                
                                Text("Correct Answer: \(answer.correctAnswer)")
                                    .foregroundColor(.gray)
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
                }
                
                Button(action: onDismiss) {
                    Text("Back to Quiz List")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(primary)
                                .shadow(color: primary.opacity(0.3), radius: 5, x: 2, y: 2)
                        )
                }
                .padding(.top, 20)
            }
            .padding(32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(appBackground.ignoresSafeArea())
    }
}
