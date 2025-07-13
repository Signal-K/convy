//
//  ShopModels.swift
//  Convo
//
//  Created by Liam Arbuckle on 17/7/2025.
//

import Foundation
import SwiftUI

struct ShopItem: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let emoji: String
    let cost: Int
}

class ShopData: ObservableObject {
    @AppStorage("xpPoints") var xpPoints: Int = 0
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
        guard xpPoints >= item.cost else { return }
        xpPoints -= item.cost
        ownedItems.append(item)
    }
    
    func owns(_ item: ShopItem) -> Bool {
        ownedItems.contains(item)
    }
}
