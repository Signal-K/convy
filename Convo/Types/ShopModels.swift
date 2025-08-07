import Foundation

struct ShopItem: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let emoji: String
    let cost: Int
}
