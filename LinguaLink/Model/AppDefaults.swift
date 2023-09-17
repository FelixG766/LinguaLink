//
//  Constant.swift
//  LinguaLink
//
//  Created by Yangru Guo on 10/9/2023.
//

import Foundation

struct AppDefaults{
    
    //MARK: - general default settings
    static let defaultTranslationProvider = GoogleCloudTranslationService()
    static let defaultSourceLanguage = "en"
    static let defaultTargetLanguage = "zh-CN"
    static let defaultTranslator = "GOOGLE"
    
    //MARK: - Google translation default settings
    struct GoogleAPI{
        static let baseURL = "https://translation.googleapis.com/language/translate/v2"
        static let apiKey = SensitiveInfo.googleAPIKey
    }
    
    //MARK: - ChatGPT translation default settings
    struct ChatGPT{
        static let apiKey = SensitiveInfo.chatGPTAPIKey
        static let translationStyle = "Normal"
        static let baseURL = "https://api.openai.com/v1/"
    }
    
}

// Define default value when there is no default setting record
extension UserDefaults {
    
    // Define keys for your UserDefaults keys
    static let translationProviderKey = "TranslationProviderKey"
    static let sourceLanguageKey = "SourceLanguageKey"
    static let targetLanguageKey = "TargetLanguageKey"
    static let translatorKey = "TranslatorKey"
    static let googleBaseURLKey = "GoogleBaseURLKey"
    static let googleApiKey = "GoogleApiKey"
    static let translationStyleKey = "TranslationStyleKey"
    
    // Define a method to retrieve a value from UserDefaults with a default value
    static func getValue<T>(forKey key: String, defaultValue: T) -> T {
        if let value = standard.object(forKey: key) as? T {
            return value
        }
        return defaultValue
    }
}

// Static language style

let styleArray = [
    "Normal",
    "Formal",
    "Literary",
    "Technical",
    "Conversational",
    "Business",
    "Medical",
    "Localization",
    "Subtitling",
    "Machine",
    "Polite",
    "Humorous"
]
