import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    private let baseURL = "https://enviably-yesterday-lustiness.ngrok-free.dev"
    
    //GENERIC REQUEST
    private func request<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        body: Data? = nil,
        requiresAuth: Bool = false
    ) async throws -> T {
        
        guard let url = URL(string: baseURL + endpoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = method
        request.httpBody = body
        
        request.setValue(
            "application/json",
            forHTTPHeaderField:"Content-Type"
        )
        
        request.setValue(
            "true",
            forHTTPHeaderField: "ngrok-skip-browser-warning"
        )
        
        if requiresAuth {
            guard let token = TokenStorage.shared.token else {
                throw URLError(.userAuthenticationRequired)
            }
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }
        
        let (data, response) = try await URLSession.shared.data(for:request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return try JSONDecoder().decode(T.self, from: data)
        default:
            let apiError = try? JSONDecoder().decode(APIError.self, from: data)
            throw NSError(
                domain: "API",
                code: httpResponse.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        apiError?.error ?? "Unknown error"
                    ]
            )
        }
    }
}

// AUTHENTICATION
extension NetworkService {
    
    func register (
        email: String,
        password: String
    ) async throws -> AuthResponse {
        
        let body = [
            "email": email,
            "password": password
        ]
        
        let data = try JSONEncoder().encode(body)
        
        let response: AuthResponse = try await request (
            endpoint: "/auth/register",
            method: "POST",
            body: data
        )
        
        TokenStorage.shared.token = response.token
        
        print(response)
        print(String(data: data, encoding: .utf8) ?? "")
        
        return response
    }
    
    func login (
        email: String,
        password: String
    ) async throws -> AuthResponse {
        
        let body = [
            "email": email,
            "password": password
        ]
        
        let data = try JSONEncoder().encode(body)
        
        let response: AuthResponse = try await request (
            endpoint: "/auth/login",
            method: "POST",
            body: data
        )
        
        TokenStorage.shared.token = response.token
        
        print(response)
        print(String(data: data, encoding: .utf8) ?? "")
        
        return response
    }
}

// CHAT
extension NetworkService {
    
    func fetchChats () async throws -> [Chat] {
        
        try await request(
            endpoint: "/chats",
            requiresAuth: true
        )
    }
    
    func createChat (
        title: String?
    ) async throws -> Chat {
        
        struct Body: Codable {
            let title: String?
        }
        
        let data = try JSONEncoder().encode(
            Body(title: title)
        )
        
        return try await request(
            endpoint: "/chats",
            method: "POST",
            body: data,
            requiresAuth: true
        )
    }
}

//MESSAGES
extension NetworkService {
    
    func fetchMessages (
        chatID: Int
    ) async throws -> [ChatMessage] {
        
        try await request(
            endpoint: "/chats/\(chatID)/messages",
            requiresAuth: true)
    }
    
    func sendMessage (
        chatID: Int,
        content: String
    ) async throws -> ChatMessage {
        struct Body: Codable {
            let content: String
        }
        
        let data = try JSONEncoder().encode(
            Body(content: content)
        )
        
        return try await request(
            endpoint: "/chats/\(chatID)/messages",
            method:"POST",
            body: data,
            requiresAuth: true)
    }
}
