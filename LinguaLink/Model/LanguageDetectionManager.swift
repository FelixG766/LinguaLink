//
//  LanguageDetectionManager.swift
//  LinguaLink
//
//  Created by Yangru Guo on 12/9/2023.
//

import Foundation
import NaturalLanguage

struct LanguageDetectionManager{
    
    //    Static language mapping from language options auto-detected by Natura Language Library to
    //    Google supported language options
    
    let languageMapping: [NLLanguage: String] = [
        .amharic: "am",
        .arabic: "ar",
        .armenian: "hy",
        .bengali: "bn",
        .bulgarian: "bg",
        .catalan: "ca",
        .simplifiedChinese: "zh-CN",
        .traditionalChinese: "zh-TW",
        .croatian: "hr",
        .czech: "cs",
        .danish: "da",
        .dutch: "nl",
        .english: "en",
        .finnish: "fi",
        .french: "fr",
        .georgian: "ka",
        .german: "de",
        .greek: "el",
        .gujarati: "gu",
        .hebrew: "he",
        .hindi: "hi",
        .hungarian: "hu",
        .icelandic: "is",
        .indonesian: "id",
        .italian: "it",
        .japanese: "ja",
        .kannada: "kn",
        .kazakh: "kk",
        .khmer: "km",
        .korean: "ko",
        .lao: "lo",
        .malay: "ms",
        .malayalam: "ml",
        .marathi: "mr",
        .mongolian: "mn",
        .norwegian: "no",
        .persian: "fa",
        .polish: "pl",
        .portuguese: "pt",
        .punjabi: "pa",
        .romanian: "ro",
        .russian: "ru",
        .slovak: "sk",
        .spanish: "es",
        .swedish: "sv",
        .tamil: "ta",
        .telugu: "te",
        .thai: "th",
        .turkish: "tr",
        .ukrainian: "uk",
        .urdu: "ur",
        .vietnamese: "vi",
    ]
    
    //    Detect language automatically from the recognised text
    
    func detectLanguage(for text: String, completion: @escaping (NLLanguage) -> Void) {
        let languageRecognizer = NLLanguageRecognizer()
        languageRecognizer.processString(text)
        
        if let detectedLanguage = languageRecognizer.dominantLanguage {
            completion(detectedLanguage)
        } else {
            completion(.undetermined)
        }
    }
    
    //    Convert to language option that are recognisable by google translation API
    
    func mappingToTranslationOptions(from detectedLanguage:NLLanguage) -> String {
        if let mappingResult = languageMapping[detectedLanguage]{
            return mappingResult
        }else{
            return "en"
        }
    }
    
    
    
}
