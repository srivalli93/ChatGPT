//
//  ContentView.swift
//  ChatGPT-iOSApp
//
//  Created by Srivalli Kanchibotla on 1/24/25.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages, id: \.id) { message in
                    messageView(message: message)
                }
            }
            HStack {
                TextField("Enter a message...", text: $viewModel.currentInput)
                Button {
                    viewModel.sendMessage()
                } label: {
                    Text("Send")
                }
            }
        }
        .padding()
    }
    
    func messageView(message: Message) -> some View {
        HStack {
            if message.role == "user" {
                Spacer()
            }
            Text(message.content)
                .padding()
                .background(message.role == "user" ? Color.blue : Color.gray.opacity(0.4))
            if message.role == "assistant" {
                Spacer()
            }
        }
    }
       
}

#Preview {
    ChatView()
        .modelContainer(for: Item.self, inMemory: true)
}
