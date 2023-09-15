//
//  TranslationService.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import Foundation

//MARK: - Translation Provider Protocol
//TranslationProvider Protocol with error handling upon completion, assign translated string for rendering, or otherwise error, in a trailling closure for error handling

protocol TranslationProvider {
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (String?, Error?) -> Void)
}

//MARK: - Google Cloud Translation API

class GoogleCloudTranslationService: TranslationProvider {
    
    private let APIKey: String
    private let baseURL:String
    
    //initialise translation services from default(Constant) settings
    init() {
        self.APIKey = UserDefaults.getValue(forKey: UserDefaults.googleApiKey, defaultValue: AppDefaults.GoogleAPI.apiKey)
        self.baseURL = UserDefaults.getValue(forKey: UserDefaults.translatorKey, defaultValue: AppDefaults.GoogleAPI.baseURL)

    }
    
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (String?, Error?) -> Void) {
        
        let result = constructTranslationRequest(text: text, sourceLanguage: sourceLanguage, targetLanguage: targetLanguage)
        switch result {
        case .success(let request):
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
    
    // MARK: - construct REST request
    
    private func constructTranslationRequest(text: String, sourceLanguage: String, targetLanguage: String) -> Result<URLRequest, Error> {
        do {
            guard var urlComponents = URLComponents(string: baseURL) else {
                throw NSError(domain: "TranslationService.RESTAPIConstruction", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid base URL"])
            }

            var queryArray = [URLQueryItem]()
            queryArray.append(URLQueryItem(name: "q", value: text))
            queryArray.append(URLQueryItem(name: "source", value: sourceLanguage))
            queryArray.append(URLQueryItem(name: "target", value: targetLanguage))
            queryArray.append(URLQueryItem(name: "key", value: APIKey))
            urlComponents.queryItems = queryArray

            guard let url = urlComponents.url else {
                throw NSError(domain: "TranslationService.RESTAPIConstruction", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid components to generate URL"])
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            return .success(request)
        } catch {
            return .failure(error)
        }
    }
    
    //MARK: - perform REST request
    private func performTranslationRequest(_ request: URLRequest, completion: @escaping (Result<String, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "TranslationService.PerformRESTRequest", code: 3 , userInfo: nil)))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let dataDict = json?["data"] as? [String: Any], let translations = dataDict["translations"] as? [[String: Any]] {
                    let translatedText = translations.first?["translatedText"] as? String
                    completion(.success(translatedText ?? ""))
                } else {
                    completion(.failure(NSError(domain: "TranslationService.PerformRESTRequest", code: 4, userInfo: nil)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

//MARK: - ChatGPT Translation API

class ChatGPTTranslationService: TranslationProvider {
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (String?, Error?) -> Void) {
        print(3)
    }
}
