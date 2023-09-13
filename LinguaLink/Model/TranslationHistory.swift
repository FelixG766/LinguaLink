//
//  TranslationHistory.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import Foundation

struct TranslationHistory: Identifiable {
    let id = UUID()
    let date: Date
    let type: String
    let topic: String
    let originalText: String
    let translatedText: String
    var compactDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

let translationHistoryArray: [TranslationHistory] = [
    TranslationHistory(date: Date(), type: "Meeting", topic: "Topic 1", originalText: "Text 1", translatedText: "Translated 1"),
    TranslationHistory(date: Date(), type: "Meeting", topic: "Topic 2", originalText: "Text 2", translatedText: "Translated 2"),
    TranslationHistory(date: Date(), type: "Book", topic: "Topic 3", originalText: "Text 3", translatedText: "Translated 3"),
    TranslationHistory(date: Date(), type: "Brochure", topic: "Topic 4", originalText: "Text 4", translatedText: "Translated 4"),
    TranslationHistory(date: Date(), type: "Document", topic: "Topic 5", originalText: "Text 5", translatedText: "Translated 5"),
    TranslationHistory(date: Date(), type: "Document", topic: "Topic 6", originalText: "Text 6", translatedText: "Translated 6"),
    TranslationHistory(date: Date(), type: "Image", topic: "Topic 7", originalText: "Text 7", translatedText: "Translated 7"),
    TranslationHistory(date: Date(), type: "Sign", topic: "Topic 8", originalText: "Text 8", translatedText: "Translated 8"),
    TranslationHistory(date: Date(), type: "Menu", topic: "Topic 9", originalText: "Text 9", translatedText: "Translated 9"),
    TranslationHistory(date: Date(), type: "Letter", topic: "Topic 10", originalText: "Text 10", translatedText: "Translated 10")
]

