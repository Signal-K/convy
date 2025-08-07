//
//  ShopModels.swift
//  Convo
//
//  Created by Liam Arbuckle on 17/7/2025.
//

import Foundation
import SwiftUI

struct ShopItem: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let name: String
    let emoji: String
    let cost: Int

    // Only compare by name for equality
    static func == (lhs: ShopItem, rhs: ShopItem) -> Bool {
        lhs.name == rhs.name
    }

    // Hash by name (so Set/Dictionary can work)
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

class ShopData: ObservableObject {
    @AppStorage("goldPieces") var goldPieces: Int = 0
    @AppStorage("ownedItemData") private var ownedItemData: Data = Data()
    
    @Published var ownedItems: [ShopItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(ownedItems) {
                ownedItemData = encoded
            }
        }
    }
    
    init() {
        if let decoded = try? JSONDecoder().decode([ShopItem].self, from: ownedItemData) {
            ownedItems = decoded
        }
    }
    
    func buy(item: ShopItem) {
        guard goldPieces >= item.cost else { return }
        if !owns(item) {
            goldPieces -= item.cost
            ownedItems.append(item)
        }
    }
    
    func owns(_ item: ShopItem) -> Bool {
        if item.name == "Default" {
            return true // Always own Default theme
        }
        return ownedItems.contains(item)
    }
}
