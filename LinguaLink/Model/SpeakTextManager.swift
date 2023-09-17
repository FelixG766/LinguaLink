//
//  SpeakTextManager.swift
//  LinguaLink
//
//  Created by Yangru Guo on 12/9/2023.
//

import Foundation
import AVFoundation
import NaturalLanguage

//MARK: - Speak Translation Protocol - Protocol design
//  To detect the finish of audio speaking, used for toggle the icon for speak language option
protocol SpeakTextManagerDelegate: AnyObject {
    func speechDidFinish()
}


class SpeakTextManager: NSObject {
    
    // Delegate to handle speech-related events, used for the target view to listen to the finish of the speech
    weak var delegate: SpeakTextManagerDelegate?
    
    // AVSpeechSynthesizer for text-to-speech synthesis
    let synthesizer = AVSpeechSynthesizer()
    
    // Language recognizer for detecting the language of text
    let languageRecognizer = NLLanguageRecognizer()
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    // Function to speak the translated text
    func speakText(translatedText: String) {
        // Detect the language of the text
        let detectedLanguage = detectLanguage(for: translatedText)
        
        // Create an AVSpeechUtterance with the translated text
        let utterance = AVSpeechUtterance(string: translatedText)
        
        // Set the voice based on the detected language
        utterance.voice = AVSpeechSynthesisVoice(language: detectedLanguage)
        
        // Start speech synthesis
        synthesizer.speak(utterance)
    }
    
    // Function to stop speech synthesis
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    // Private function to detect the language of text
    private func detectLanguage(for text: String) -> String {
        languageRecognizer.processString(text)
        if let languageCode = languageRecognizer.dominantLanguage?.rawValue {
            return languageCode
        }
        return "en-US" // Default to English if language detection fails
    }
}

// Extension to conform to AVSpeechSynthesizerDelegate
extension SpeakTextManager: AVSpeechSynthesizerDelegate {
    // Delegate method called when speech synthesis finishes
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // Notify the delegate that speech has finished
        delegate?.speechDidFinish()
    }
}
