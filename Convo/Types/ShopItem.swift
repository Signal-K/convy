import Foundation

public struct ShopItem: Identifiable, Codable, Equatable {
    public let id: UUID
    public let name: String
    public let emoji: String
    public let cost: Int

    public init(id: UUID, name: String, emoji: String, cost: Int) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.cost = cost
    }
}
