import Combine
import Foundation

final class ChatViewModel: ObservableObject {
    @Published var messages: [LocalMessage] = []
    @Published var inputText = ""
    @Published var isWaitingForAssistant = false
    
    private let networkService = NetworkService.shared
    
    let chatID: Int
    
    init(chatID: Int) {
        self.chatID = chatID
    }
    
    func loadMessages() async {
        do {
            let fetched = try await networkService.fetchMessages(chatID: chatID)
            messages = fetched.map { LocalMessage(from: $0) }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func sendMessage() async {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        let chatMessage = LocalMessage(
            role: .user,
            content: text
        )
        messages.append(chatMessage)
        
        inputText = ""
        
        isWaitingForAssistant = true
        
        do {
            let response = try await networkService.sendMessage(
                chatID: chatID,
                content: text
            )
            messages.append(LocalMessage(from: response))
        } catch {
            print(error.localizedDescription)
        }
        
        isWaitingForAssistant = false
    }
    

}
