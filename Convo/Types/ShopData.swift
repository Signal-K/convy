//
//  ShopView.swift
//  Convo
//
//  Created by Liam Arbuckle on 17/7/2025.
//

import SwiftUI

private let appBackground = Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1))
private let surface = Color.white
private let primary = Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1))

struct ShopView: View {
    @StateObject private var shopData = ShopData()
    
    let shopItems: [ShopItem] = [
        ShopItem(id: UUID(), name: "Sunglasses", emoji: "🕶️", cost: 10),
        ShopItem(id: UUID(), name: "Coffee", emoji: "☕", cost: 15),
        ShopItem(id: UUID(), name: "Hat", emoji: "🧢", cost: 20)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("🛍️ Shop")
                    .font(.largeTitle.bold())
                    .foregroundColor(primary)
                    .padding(.top)
                
                // Show gold pieces and completed quizzes as gold
                HStack(spacing: 16) {
                    Text("Gold Pieces: \(shopData.goldPieces)")
                        .font(.headline)
                        .foregroundColor(.yellow)
                    HStack(spacing: 4) {
                        ForEach(0..<shopData.completedQuizCount, id: \.self) { _ in
                            Image(systemName: "circle.fill")
                                .foregroundColor(.yellow)
                        }
                        Text("\(shopData.completedQuizCount) completed quizzes")
                            .font(.subheadline)
                            .foregroundColor(.yellow)
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Items for Sale")
                        .font(.title3.bold())
                        .foregroundColor(primary)
                    
                    ForEach(shopItems) { item in
                        HStack {
                            Text("\(item.emoji) \(item.name)")
                                .font(.body)
                            Spacer()
                            Text("\(item.cost) Points")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Button(action: {
                                shopData.buy(item: item)
                            }) {
                                Text(shopData.owns(item) ? "Owned" : "Buy")
                                    .font(.caption.bold())
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(shopData.owns(item) ? .gray.opacity(0.4) : primary)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .disabled(shopData.owns(item))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(surface)
                                .shadow(color: .white.opacity(0.6), radius: 4, x: -2, y: -2)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
                        )
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Your Inventory")
                        .font(.title3.bold())
                        .foregroundColor(primary)
                    
                    if shopData.ownedItems.isEmpty {
                        Text("You don't own anything yet.")
                            .foregroundColor(.gray)
                            .italic()
                    } else {
                        ForEach(shopData.ownedItems) { item in
                            HStack {
                                Text("\(item.emoji) \(item.name)")
                                Spacer()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(surface)
                                    .shadow(color: .white.opacity(0.6), radius: 4, x: -2, y: -2)
                                    .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
                            )
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(appBackground.ignoresSafeArea())
    }
}

#Preview {
    ShopView()
}
