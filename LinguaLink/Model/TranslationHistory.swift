//
//  TranslationHistory.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import Foundation

struct TranslationHistory: Identifiable {
    let id = UUID()
    let originalText: String
    let translatedText: String
}
