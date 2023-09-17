//
//  OpenAIServiceManager.swift
//  LinguaLink
//
//  Created by Yangru Guo on 15/9/2023.
//

import Foundation
import Combine
import Alamofire

class OpenAIServiceManager {
    
    // Prepare the query message for translation service
    func prepareTranslationDataForAIService(text: String, from sourceLanguage: String, to targetLanguage: String) -> String {
        
        // Construct a query string for translation
        let queryString = "Translate \"" + text + "\" from " + sourceLanguage + " to " + targetLanguage + " in a style of " + AppDefaults.ChatGPT.translationStyle + " and ensure translated text is understandable, grammatically correct and well-structured"
        return queryString
    }
    
    // Send the translation request to ChatGPT
    func sendTranslationRequest(queryString: String) -> AnyPublisher<ChatGPTCompletionsResponse, Error> {
        let body = ChatGPTAPICompletionsBody(model: "text-davinci-003", prompt: queryString, temperature: 0.7, max_tokens: 2000)
        let headers: HTTPHeaders = ["Authorization": "Bearer \(AppDefaults.ChatGPT.apiKey)"]
        
        return Future { [weak self] promise in
            // Ensure self is not nil and proceed with the request
            guard self != nil else {
                return
            }
            
            AF.request(AppDefaults.ChatGPT.baseURL + "completions", method: .post, parameters: body, encoder: .json, headers: headers)
                .responseDecodable(of: ChatGPTCompletionsResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        promise(.success(result))
                    case .failure(let error as NSError):
                        promise(.failure(NSError(domain: "OpenAIServiceManager.sendTrasnlationRequest", code: ErrorCodes.failToReceiveRespondFromChatGPT,userInfo: error.userInfo)))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}

// Structure to represent the body of a ChatGPT API completion request
struct ChatGPTAPICompletionsBody: Encodable {
    let model: String
    let prompt: String
    let temperature: Float?
    let max_tokens: Int
}

// Structure to represent a response from ChatGPT API
struct ChatGPTCompletionsResponse: Decodable {
    let id: String
    let choices: [ChatGPTCompetitionsChoice]
}

// Structure to represent a choice in ChatGPT API response
struct ChatGPTCompetitionsChoice: Decodable {
    let text: String
}
