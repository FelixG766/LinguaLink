//
//  TranslationServiceViewModel.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import Foundation

class TranslationViewModel: ObservableObject {
    
    @Published var translationHistory: [TranslationHistory] = []
    @Published var translation = ""

    private let translator: TranslationProvider

    init() {
        self.translator = Constant.defaultTranslationProvider
    }

    func translateWithSelectedModel(_ text: String, from sourceLanguage: String, to targetLanguage: String, with selectedModel:String){
        
        if selectedModel == "GOOGLE"{
            
            translator.translate(text, from: sourceLanguage, to: targetLanguage) { translatedText, error in
                DispatchQueue.main.async {
                    if let translation = translatedText {
                        self.translation = translation
                        let historyItem = TranslationHistory(originalText: text, translatedText: translation)
                        self.translationHistory.append(historyItem)
                    } else if let error = error {
                        print(error)
                    }
                }
            }
        }
    }
}
