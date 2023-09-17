//
//  File.swift
//  LinguaLink
//
//  Created by Yangru Guo on 12/9/2023.
//

import Foundation

class PopUpViewModel  {
    
    // Class to save translation history, the input text and translated text will not be editable in current design
    
    let persistenceController = PersistenceController.shared
    
    func saveTranslationHistory(date:Date, topic:String, type:String, originalText:String, translatedText:String){
        let newTranslationHistory = TranslationHistory(date:date, type:type, topic:topic, originalText:originalText, translatedText: translatedText)
        persistenceController.saveTranslationHistory(translationHistory: newTranslationHistory)
    }
    
    
}
