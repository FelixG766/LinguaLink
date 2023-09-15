//
//  SpeakTextManager.swift
//  LinguaLink
//
//  Created by Yangru Guo on 12/9/2023.
//

import Foundation
import AVFoundation
import NaturalLanguage

protocol SpeakTextManagerDelegate: AnyObject {
    func speechDidFinish()
}

class SpeakTextManager: NSObject {
    
    weak var delegate: SpeakTextManagerDelegate?
    let synthesizer = AVSpeechSynthesizer()
    let languageRecognizer = NLLanguageRecognizer()

    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func speakText(translatedText: String) {
        // Detect the language of the text
        let detectedLanguage = detectLanguage(for: translatedText)
        
        // Set the language for speech synthesis
        let utterance = AVSpeechUtterance(string: translatedText)
        utterance.voice = AVSpeechSynthesisVoice(language: detectedLanguage)
        synthesizer.speak(utterance)
    }
    
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    private func detectLanguage(for text: String) -> String {
        languageRecognizer.processString(text)
        if let languageCode = languageRecognizer.dominantLanguage?.rawValue {
            return languageCode
        }
        return "en-US" // Default to English if language detection fails
    }
}

extension SpeakTextManager: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // Notify the delegate that speech has finished
        delegate?.speechDidFinish()
    }
}

