import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let email: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case createdAt = "created_at"
    }
}

struct AuthResponse: Codable {
    let token: String
    let user: User
}


