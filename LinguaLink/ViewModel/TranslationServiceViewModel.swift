//
//  TranslationServiceViewModel.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import Foundation
import AVFoundation
import UIKit

class TranslationViewModel: ObservableObject, SpeakTextManagerDelegate {
    
    @Published var translationHistory: [TranslationHistory] = []
    @Published var translation = ""
    @Published var inputText = ""
    @Published var isSpeaking = false

    private let translator: TranslationProvider
    private let ocrManager: OCRManager = OCRManager()
    private let speakTextManager = SpeakTextManager()

    init() {
        self.translator = Constant.defaultTranslationProvider
        speakTextManager.delegate = self
    }
    
//MARK: - Translate with Selected Model
    func translateWithSelectedModel(_ text: String, from sourceLanguage: String, to targetLanguage: String, with selectedModel:String){
        
        if selectedModel == "GOOGLE"{
            translator.translate(text, from: sourceLanguage, to: targetLanguage) { translatedText, error in
                DispatchQueue.main.async {
                    if let translation = translatedText {
                        self.translation = translation
                    } else if let error = error {
                        print(error)
                    }
                }
            }
        }
    }
    
    //MARK: - Extract Text From Image
    func recognizeText(from image: UIImage) {
        inputText = ocrManager.performOCRRequest(to: image)
    }
    
    //MARK: - Speak or Stop Speak Text From Output Field
    func speakOrStopSpeakText() {
        if(!isSpeaking){
            speakTextManager.speakText(translatedText: translation)
            isSpeaking = true
        }else{
            speakTextManager.stopSpeaking()
            isSpeaking = false
        }
    }
    
    //MARK: - Protocol to Listen to Completion of Speaker
    func speechDidFinish() {
        isSpeaking = false
    }
    
}
