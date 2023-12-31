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
    
    // Translation View Model class to handle data flows related to translation tasks
    
    @Published var translation = ""
    @Published var inputText = ""
    @Published var isSpeaking = false
    
    private var translationProvider: TranslationProvider
    
    //MARK: - Class Composition
    private let ocrManager: OCRManager = OCRManager()
    private let speakTextManager = SpeakTextManager()
    
    init() {
        self.translationProvider = UserDefaults.getValue(forKey: UserDefaults.translationProviderKey, defaultValue: AppDefaults.defaultTranslationProvider)
        speakTextManager.delegate = self
    }
    
    //MARK: - Translate with Selected Model
    func translateWithSelectedModel(_ text: String, from sourceLanguage: String, to targetLanguage: String, with selectedModel:String){
        //MARK: - Handle Empty Input
        guard text != "" else{
            print("No text to be translated...")
            return
        }
        //MARK: - Google Translation
        if selectedModel == "GOOGLE"{
            translationProvider = GoogleCloudTranslationService()
            translationProvider.translate(text, from: sourceLanguage, to: targetLanguage) { translatedText, error in
                DispatchQueue.main.async {
                    if let translation = translatedText {
                        self.translation = translation
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        //MARK: - ChatGPT Translation
        else if selectedModel == "CHATGPT"{
            translationProvider = ChatGPTTranslationService()
            translationProvider.translate(text, from: sourceLanguage, to: targetLanguage){ translatedText, error in
                DispatchQueue.main.async {
                    if let translation = translatedText {
                        self.translation = translation
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
    }
    
    //MARK: - Reset Translation View
    func resetTranslation(){
        inputText = ""
        translation = ""
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
