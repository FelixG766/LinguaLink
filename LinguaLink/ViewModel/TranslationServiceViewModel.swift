//
//  TranslationServiceViewModel.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import Foundation

class TranslationViewModel: ObservableObject {
    
    @Published var translationHistory: [TranslationHistory] = []

    private let translator: TranslationProvider

    init(translator: TranslationProvider) {
        self.translator = translator
    }

    func translateAndStore(_ text: String, from sourceLanguage: String, to targetLanguage: String) {
        translator.translate(text, from: sourceLanguage, to: targetLanguage) { translation, error in
            if let translation = translation {
                let historyItem = TranslationHistory(originalText: text, translatedText: translation)
                self.translationHistory.append(historyItem)
            } else if let error = error {
                // Handle the error.
            }
        }
    }
}
