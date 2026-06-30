//
//  ChatRowView.swift
//  AIDos
//
//  Created by Асан Мырзахметов on 30.06.2026.
//

import SwiftUI

struct ChatRowView: View {
    var body: some View {
            HStack {
                VStack (alignment: .leading) {
                    Text("Панические приступы")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("Нууу у тебя что то не так иди нахуй пон")
                        .lineLimit(2)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.gray)
                }
                .padding(15)
                VStack (alignment: .trailing) {
                    Text("Wednesday")
                        .foregroundStyle(.gray)
                    Spacer()
                    Text("12:30")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .padding(15)
            }
    }
}

#Preview {
    ChatRowView()
}
