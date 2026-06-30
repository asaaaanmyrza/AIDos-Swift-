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
        VStack {
            header()
            NavigationStack {
                ScrollView {
                    ForEach(/*viewModel.chats*/1...3, id: \.self) { chat in
                            ChatRowView()
                        }
                    }
                .toolbar {
                    ToolbarItem (placement: .navigationBarLeading) {
                            Text("Чаты")
                            .fixedSize(horizontal: true, vertical: false)
                            .font(.title)
                            .bold()
                    }
                    .sharedBackgroundVisibility(.hidden)
                
                    
                    ToolbarItem (placement: .navigationBarTrailing) {
                        HStack {
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
                }
                    .task {
                        await viewModel.fetchChats()
                    }
            }
        }
        .ignoresSafeArea()
    }
}

extension ChatsListView {
    //HEADER
    func header() -> some View {
        return ZStack (alignment: .top) {
            RoundedRectangle(cornerRadius: 60)
                .fill(LinearGradient(
                    colors: [
                        .accentPurple.opacity(0.8),
                        .accentPurple
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .frame(width: .infinity, height: 500)
                .frame(height: 180, alignment: .bottom)
                .clipped()
            VStack {
                Text ("AI Dos")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.largeTitle)
                Text ("Your mental assistant")
                    .foregroundStyle(.white)
            }
            .padding(.top, 75)
        }
    }
}

#Preview {
    ChatsListView()
}
