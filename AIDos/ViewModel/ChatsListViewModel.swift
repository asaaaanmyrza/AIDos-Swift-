import Foundation
import Combine
import SwiftUI

final class ChatsListViewModel: ObservableObject {
    @Published var chats: [Chat] = []
    @Published var isLoading = false
    
    let auth: AuthViewModel
    let networkService = NetworkService.shared
    
    init() {
        self.auth = AuthViewModel()
    }
    
    func fetchChats() async {
        isLoading = true
        do {
            chats = try await networkService.fetchChats()
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
    }
    
    func createChat(title: String?) async -> Chat? {
        do {
            let chat = try await networkService.createChat(title: title)
            chats.insert(chat, at: 0)
            return chat
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
