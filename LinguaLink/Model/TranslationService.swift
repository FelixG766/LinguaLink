//
//  TranslationService.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import Foundation
import Combine

//MARK: - Translation Provider Protocol - Protocol Design
//TranslationProvider Protocol with error handling upon completion, assign translated string for rendering, or otherwise error, in a trailling closure for error handling

protocol TranslationProvider {
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (String?, Error?) -> Void)
}

//MARK: - Google Cloud Translation API

class GoogleCloudTranslationService: TranslationProvider {
    
    private let APIKey: String
    private let baseURL: String
    
    // Initialize translation services from default settings
    init() {
        self.APIKey = UserDefaults.getValue(forKey: UserDefaults.googleApiKey, defaultValue: AppDefaults.GoogleAPI.apiKey)
        self.baseURL = UserDefaults.getValue(forKey: UserDefaults.translatorKey, defaultValue: AppDefaults.GoogleAPI.baseURL)
    }
    
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (String?, Error?) -> Void) {
        
        // Construct the translation request
        let result = constructTranslationRequest(text: text, sourceLanguage: sourceLanguage, targetLanguage: targetLanguage)
        switch result {
        case .success(let request):
            // Perform the translation request
            performTranslationRequest(request) { result in
                switch result {
                case .success(let translatedText):
                    completion(translatedText, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        case .failure(let error):
            completion(nil, error)
        }
    }
    
    // MARK: - Construct REST request
    
    private func constructTranslationRequest(text: String, sourceLanguage: String, targetLanguage: String) -> Result<URLRequest, Error> {
        do {
            // Create URL components and build the URL
            guard var urlComponents = URLComponents(string: baseURL) else {
                throw NSError(domain: "TranslationService.RESTAPIConstruction", code: ErrorCodes.failToConstructURLComponentsError, userInfo: [NSLocalizedDescriptionKey: "Invalid base URL"])
            }
            
            // Build query parameters
            var queryArray = [URLQueryItem]()
            queryArray.append(URLQueryItem(name: "q", value: text))
            queryArray.append(URLQueryItem(name: "source", value: sourceLanguage))
            queryArray.append(URLQueryItem(name: "target", value: targetLanguage))
            queryArray.append(URLQueryItem(name: "key", value: APIKey))
            urlComponents.queryItems = queryArray
            
            // Validate and create the request
            guard let url = urlComponents.url else {
                throw NSError(domain: "TranslationService.RESTAPIConstruction", code: ErrorCodes.failToConstructURLError, userInfo: [NSLocalizedDescriptionKey: "Invalid components to generate URL"])
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            return .success(request)
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: - Perform REST request
    
    private func performTranslationRequest(_ request: URLRequest, completion: @escaping (Result<String, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "TranslationService.PerformRESTRequest", code: ErrorCodes.failToGetDataFromGoogleAPI , userInfo: nil)))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let dataDict = json?["data"] as? [String: Any], let translations = dataDict["translations"] as? [[String: Any]] {
                    let translatedText = translations.first?["translatedText"] as? String
                    completion(.success(translatedText ?? ""))
                } else {
                    completion(.failure(NSError(domain: "TranslationService.PerformRESTRequest", code: ErrorCodes.failInJSONParsingOrTypeCasting, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// MARK: - ChatGPT Translation API

class ChatGPTTranslationService: TranslationProvider {
    
    private let openAIServiceManager = OpenAIServiceManager()
    
    var cancellables = Set<AnyCancellable>()
    
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (String?, Error?) -> Void) {
        
        // Prepare the query message for the AI service
        let queryMessage = openAIServiceManager.prepareTranslationDataForAIService(text: text, from: sourceLanguage, to: targetLanguage)
        
        // Send the translation request and handle the response
        openAIServiceManager.sendTranslationRequest(queryString: queryMessage)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break // Finished without errors
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { response in
                // Extract and handle the translated response
                guard let translationResponse = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else {
                    let error = NSError(domain: "OpenAIResponseSelection", code: ErrorCodes.failToReceiveRespondFromChatGPT, userInfo: [NSLocalizedDescriptionKey: "Error in obtaining responses from chatGPT"])
                    print("Error in textResponse: \(error)")
                    return completion(nil, error)
                }
                return completion(translationResponse, nil)
            })
            .store(in: &cancellables)
    }
}
