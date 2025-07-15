//
//  StreakCalendar.swift
//  Convo
//
//  Created by Liam Arbuckle on 8/6/2025.
//

import SwiftUI

private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))

import SwiftUI

struct StreakCalendarView: View {
    @State private var showFullStreak = false
    
    let today = Calendar.current.startOfDay(for: Date())
    let daysToShow = 28

    let streakDates: Set<Date> = demoStreakDates()

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Streak")
                .font(.largeTitle.bold())
                .foregroundColor(primary)
                .padding(.top)

            let calendar = Calendar.current
            let dates = (0..<daysToShow).map { offset in
                calendar.date(byAdding: .day, value: -offset, to: today)!
            }.reversed()

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 7), spacing: 12) {
                ForEach(dates, id: \.self) { date in
                    let isMarked = streakDates.contains(calendar.startOfDay(for: date))
                    VStack {
                        Text("\(calendar.component(.day, from: date))")
                            .font(.caption2)
                            .foregroundColor(isMarked ? .white : .gray)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(isMarked ? primary : surface)
                                    .shadow(color: .white.opacity(0.6), radius: 3, x: -2, y: -2)
                                    .shadow(color: .black.opacity(0.08), radius: 2, x: 2, y: 2)
                            )
                    }
                }
            }

            Text("Green = Quiz completed")
                .font(.caption)
                .foregroundColor(.gray)

            Button("View Full Streak") {
                showFullStreak = true
            }
            .font(.subheadline.bold())
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(primary)
            .cornerRadius(10)
            .padding(.top)

            Spacer()
        }
        .padding()
        .background(appBackground.ignoresSafeArea())
        .sheet(isPresented: $showFullStreak) {
            FullStreakCalendarView(streakDates: streakDates)
        }
    }
}

#Preview {
    StreakCalendarView()
}
