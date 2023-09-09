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

//MARK: - General Translation
class Translator: TranslationProvider {
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (String?, Error?) -> Void) {
        print(1)
    }
    
    // Translation logic using general translation.
}

//MARK: - Google Cloud Translation API
class GoogleCloudTranslationService: TranslationProvider {
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (String?, Error?) -> Void) {
        print(2)
    }
    
    // Google Cloud Translation API.
}

//MARK: - ChatGPT Translation API
class ChatGPTTranslationService: TranslationProvider {
    func translate(_ text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (String?, Error?) -> Void) {
        print(3)
    }
    
    // ChatGPT API integration.
}
