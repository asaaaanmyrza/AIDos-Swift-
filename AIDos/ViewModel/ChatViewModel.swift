import Combine
import Foundation

final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var inputText = ""
    @Published var isWaitingForAssistant = false
    
    let chatID: Int
    
    init(chatID: Int) {
        self.chatID = chatID
    }
    
    func fetchMessages() async {
        do {
            messages = try await NetworkService.shared.fetchMessages(chatID: chatID)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    

}
