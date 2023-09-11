//
//  TranslationServiceViewModel.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import Foundation
import UIKit

class TranslationViewModel: ObservableObject {
    
    @Published var translationHistory: [TranslationHistory] = []
    @Published var translation = ""
    @Published var inputText = ""

    private let translator: TranslationProvider
    private let ocrManager: OCRManager = OCRManager()

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
    
    func recognizeText(from image: UIImage) {
        inputText = ocrManager.performOCRRequest(to: image)
    }
}
