import Foundation

struct Chat: Identifiable, Codable {
    let id: Int
    let userId: Int
    let title: String?
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title
        case createdAt = "created_at"
    }
}

struct ChatMessage: Identifiable, Codable {
    let id: Int
    let chatId: Int
    let role: String
    let content: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case chatId = "chat_id"
        case role
        case content
        case createdAt = "created_at"
    }
}
