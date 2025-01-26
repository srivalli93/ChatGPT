//
//  OpenAIService.swift
//  ChatGPT-iOSApp
//
//  Created by Srivalli Kanchibotla on 1/24/25.
//

import Foundation
import Alamofire

class OpenAIService {
    
    private let endpoint = "https://api.openai.com/v1/chat/completions"
    
    func sendMessageToOpenAI(_ messages: [Message]) async -> OpenAIChatResponse? {
        
        let apiKey = ""
        
        let openAIMessages = messages.map({OpenAIChatMessage(role: $0.role, content: $0.content)})
        
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAIMessages)
        
        print(body)
        
        let headers: HTTPHeaders = ["Content-Type": "application/json" ,
                                    "Authorization" : "Bearer \(apiKey)"]
        
        guard let jsonData = try? JSONEncoder().encode(body) else {
            print("Error encoding JSON body")
            return nil
        }
        
        guard let url = URL(string: endpoint) else {
            print("Error creating URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue( "application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try! await URLSession.shared.data(for: request)
        
        // Debugging: Print the raw response for inspection
        if let rawResponseString = String(data: data, encoding: .utf8) {
            print("Raw Response: \(rawResponseString)")
        }
        
        let responseData = try! JSONDecoder().decode(OpenAIChatResponse.self, from: data)
        return responseData
    }
}

struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
}

struct OpenAIChatMessage: Codable {
    let role: String
    let content: String
}

//enum SenderRole: String, Codable {
//    case system
//    case user
//    case assistant
//}

struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
}

struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}
