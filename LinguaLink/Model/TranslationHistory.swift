//
//  TranslationHistory.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import Foundation

struct TranslationHistory: Identifiable,Hashable {
    
    let id = UUID()
    let date: Date
    let type: String
    let topic: String
    let originalText: String
    let translatedText: String
    // Computed property for getting date in a compact format
    var compactDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}


