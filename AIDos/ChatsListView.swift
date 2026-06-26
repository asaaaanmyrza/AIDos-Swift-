//
//  ChatListView.swift
//  AIDos
//
//  Created by Асан Мырзахметов on 24.06.2026.
//

import SwiftUI

struct ChatsListView: View {
    
    @StateObject private var viewModel = ChatsListViewModel()
    
    var body: some View {
        LazyVStack {
            NavigationStack {
                List(viewModel.chats) { chat in
                    Text(chat.title ?? "")
                        .background(Color.background)
                        .padding()
                }
                .toolbar {
                    Button ("New Chat", systemImage: "plus") {
                        Task {
                            await viewModel.createChat(title: "Test")
                        }
                    }
                    Button ("Logout", systemImage: "person") {
                        viewModel.auth.logout()
                    }
                }
            }
            .task {
                await viewModel.fetchChats()
            }
        }
    }
}

#Preview {
    ChatsListView()
}
