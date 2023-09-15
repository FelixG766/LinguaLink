//
//  OpenAIServiceManager.swift
//  LinguaLink
//
//  Created by Yangru Guo on 15/9/2023.
//

import Foundation
import Combine
import NaturalLanguage

class OpenAIServiceManager {
    
    let baseURL = "https://api.openai.com/v1/"

    func sendMessage(message: String) -> AnyPublisher<OpenAICompletionsResponse, Error> {
        let body = OpenAICompletionsBody(model: "text-davinci-003", prompt: message, temperature: 0.7, max_tokens: 256)
        let endpoint = URL(string: baseURL + "completions")!
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("Bearer \(AppDefaults.ChatGPT.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: OpenAICompletionsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct OpenAICompletionsBody:Encodable{
    let model: String
    let prompt: String
    let temperature:Float?
    let max_tokens:Int
}

struct OpenAICompletionsResponse:Decodable {
    let id:String
    let choices:[OpenAICompetitionsChoice]
}

struct OpenAICompetitionsChoice:Decodable {
    let text:String
}
