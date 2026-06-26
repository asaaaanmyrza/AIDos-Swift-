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
    let chatID: Int
    let role: MessageRole
    let content: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case chatID = "chat_id"
        case role
        case content
        case createdAt = "created_at"
    }
}

enum MessageRole: String, Codable {
    case user
    case assistant
}

struct LocalMessage: Identifiable {
    let id: UUID
    let serverID: Int?
    let role: MessageRole
    let content: String
    var isPending: Bool
    
    init(from message: ChatMessage) {
        self.id = UUID()
        self.serverID = message.id
        self.role = message.role
        self.content = message.content
        self.isPending = false
    }
    
    init(role: MessageRole, content: String, isPending: Bool = false) {
        self.id = UUID()
        self.serverID = nil
        self.role = role
        self.content = content
        self.isPending = isPending
    }
}
