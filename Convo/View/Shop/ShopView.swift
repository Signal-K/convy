//
//  ShopView.swift
//  Convo
//
//  Created by Liam Arbuckle on 17/7/2025.
//

import SwiftUI

let defaultTheme = Theme(
    name: "Default",
    primary: Color(#colorLiteral(red: 0.23, green: 0.43, blue: 0.67, alpha: 1)),
    appBackground: Color(#colorLiteral(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)),
    surface: Color.white
)

let darkTheme = Theme(
    name: "Dark",
    primary: Color.white,
    appBackground: Color.black,
    surface: Color.gray.opacity(0.2)
)

let bubblegumTheme = Theme(
    name: "Bubblegum",
    primary: Color.pink,
    appBackground: Color(#colorLiteral(red: 1.0, green: 0.8, blue: 0.9, alpha: 1)),
    surface: Color(#colorLiteral(red: 1, green: 0.7, blue: 0.8, alpha: 1))
)

let neonTheme = Theme(
    name: "Neon",
    primary: Color.green,
    appBackground: Color.black,
    surface: Color(#colorLiteral(red: 0.1, green: 0.1, blue: 0.1, alpha: 1))
)

let allThemes = [defaultTheme, darkTheme, bubblegumTheme, neonTheme]

struct ShopView: View {
    @StateObject private var shopData = ShopData()
    @ObservedObject private var themeManager = ThemeManager.shared
    @AppStorage("activeTheme") private var activeTheme: String = "Default"
    
    let shopItems: [ShopItem] = [
        ShopItem(id: UUID(), name: "Sunglasses", emoji: "🕶️", cost: 10),
        ShopItem(id: UUID(), name: "Coffee", emoji: "☕", cost: 15),
        ShopItem(id: UUID(), name: "Hat", emoji: "🧢", cost: 20)
    ]
    
    let themes: [ShopItem] = [
        ShopItem(id: UUID(), name: "Default", emoji: "🎨", cost: 0),
        ShopItem(id: UUID(), name: "Dark", emoji: "🌙", cost: 4),
        ShopItem(id: UUID(), name: "Bubblegum", emoji: "🍬", cost: 4),
        ShopItem(id: UUID(), name: "Neon", emoji: "🌈", cost: 4)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("🛍️ Shop")
                    .font(.largeTitle.bold())
                    .foregroundColor(themeManager.primary)
                    .padding(.top)
                
                VStack(spacing: 8) {
                    Text("Gold pieces Available: \(shopData.goldPieces)")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Button("Add 1 Gold") {
                        shopData.goldPieces += 1
                    }
                    .font(.caption.bold())
                    .padding(8)
                    .background(themeManager.primary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Items for Sale")
                        .font(.title3.bold())
                        .foregroundColor(themeManager.primary)
                    
                    ForEach(shopItems) { item in
                        ShopItemRow(
                            item: item,
                            owns: shopData.owns(item),
                            canAfford: shopData.goldPieces >= item.cost
                        ) {
                            shopData.buy(item: item)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Customisation")
                        .font(.title3.bold())
                        .foregroundColor(themeManager.primary)
                    
                    ForEach(themes) { themeItem in
                        HStack {
                            Text("\(themeItem.emoji) \(themeItem.name)")
                                .font(.body)
                            Spacer()
                            if themeItem.cost > 0 {
                                Text("\(themeItem.cost) Gold")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            if shopData.owns(themeItem) {
                                Button(action: {
                                    activeTheme = themeItem.name
                                    if let selectedTheme = allThemes.first(where: { $0.name == themeItem.name }) {
                                        themeManager.apply(theme: selectedTheme)
                                    }
                                }) {
                                    Text(activeTheme == themeItem.name ? "Active" : "Apply")
                                        .font(.caption.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(activeTheme == themeItem.name ? Color.gray.opacity(0.4) : themeManager.primary)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            } else {
                                Button(action: {
                                    if shopData.goldPieces >= themeItem.cost {
                                        shopData.buy(item: themeItem)
                                    }
                                }) {
                                    Text("Buy")
                                        .font(.caption.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(themeManager.primary)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .disabled(shopData.goldPieces < themeItem.cost)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(themeManager.surface)
                                .shadow(color: .white.opacity(0.6), radius: 4, x: -2, y: -2)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
                        )
                    }
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Your Inventory")
                        .font(.title3.bold())
                        .foregroundColor(themeManager.primary)
                    
                    let allOwned = shopData.ownedItems + themes.filter { $0.name == "Default" }
                    
                    if allOwned.isEmpty {
                        Text("You don't own anything yet.")
                            .foregroundColor(.gray)
                            .italic()
                    } else {
                        ForEach(allOwned) { item in
                            HStack {
                                Text("\(item.emoji) \(item.name)")
                                Spacer()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(themeManager.surface)
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
        .background(themeManager.appBackground.ignoresSafeArea())
        .onAppear {
            // Apply stored active theme on appear
            if let themeToApply = allThemes.first(where: { $0.name == activeTheme }) {
                themeManager.apply(theme: themeToApply)
            }
        }
    }
}

// MARK: - ShopItemRow

struct ShopItemRow: View {
    let item: ShopItem
    let owns: Bool
    let canAfford: Bool
    let onBuy: () -> Void
    
    @ObservedObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        HStack {
            Text("\(item.emoji) \(item.name)")
                .font(.body)
            Spacer()
            Text("\(item.cost) Gold")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: onBuy) {
                Text(owns ? "Owned" : "Buy")
                    .font(.caption.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(owns ? Color.gray.opacity(0.4) : themeManager.primary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(owns || !canAfford)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(themeManager.surface)
                .shadow(color: .white.opacity(0.6), radius: 4, x: -2, y: -2)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 2)
        )
    }
}
