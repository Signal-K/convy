//
//  FullCalendar.swift
//  Convo
//
//  Created by Liam Arbuckle on 9/7/2025.
//

private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))
private let border = Color(#colorLiteral(red: 0.78, green: 0.83, blue: 0.9, alpha: 1))

import SwiftUI

struct FullStreakCalendarView: View {
    let streakDates: Set<Date>

    var months: [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0...12).map {
            calendar.date(byAdding: .month, value: -11 + $0, to: today)!
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ForEach(months, id: \.self) { monthStart in
                    MonthStreakGrid(monthStart: monthStart, streakDates: streakDates)
                }
            }
            .padding()
        }
        .background(appBackground.ignoresSafeArea())
    }
}

struct MonthStreakGrid: View {
    let monthStart: Date
    let streakDates: Set<Date>

    var body: some View {
        let calendar = Calendar.current
        let monthName = monthStart.formatted(.dateTime.month().year())
        let range = calendar.range(of: .day, in: .month, for: monthStart) ?? (1..<31)
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: monthStart))!
        let firstWeekday = calendar.component(.weekday, from: startOfMonth) - 1 // zero-indexed

        let days: [Date?] = Array(repeating: nil, count: firstWeekday) +
            range.compactMap { day -> Date? in
                calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
            }

        return VStack(alignment: .leading, spacing: 12) {
            Text(monthName)
                .font(.headline)
                .foregroundColor(primary)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: 7), spacing: 6) {
                ForEach(days.indices, id: \.self) { i in
                    if let date = days[i] {
                        let isMarked = streakDates.contains(calendar.startOfDay(for: date))
                        Text("\(calendar.component(.day, from: date))")
                            .font(.caption2)
                            .foregroundColor(isMarked ? .white : .gray)
                            .frame(width: 28, height: 28)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(isMarked ? primary : surface)
                                    .shadow(color: .white.opacity(0.6), radius: 2, x: -1, y: -1)
                                    .shadow(color: .black.opacity(0.08), radius: 2, x: 1, y: 1)
                            )
                    } else {
                        Color.clear.frame(width: 28, height: 28)
                    }
                }
            }
        }
    }
}

func demoStreakDates() -> Set<Date> {
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    var dates = Set<Date>()
    for offset in [0, 1, 2, 4, 6, 7, 10, 11, 12, 14, 20, 22, 24, 31, 40, 66, 88, 120, 170, 222, 260] {
        if let day = calendar.date(byAdding: .day, value: -offset, to: today) {
            dates.insert(day)
        }
    }
    return dates
}
