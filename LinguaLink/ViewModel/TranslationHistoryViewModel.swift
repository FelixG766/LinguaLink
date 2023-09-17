//
//  TranslationHistoryViewModel.swift
//  LinguaLink
//
//  Created by Yangru Guo on 14/9/2023.
//

import Foundation
import CoreData

class TranslationHistoryViewModel:ObservableObject {
    
    // Translation History View Model class to handle data flows related to reload, delete, fetch, update translation history records
    
    @Published var translationHistoryArray:[TranslationHistory] = []
    private var persistenceController = PersistenceController.shared
    
    init() {
        self.translationHistoryArray = fetchTranslationHistory()
    }
    
    //MARK: - Fetch all translation history in core data
    func fetchTranslationHistory() -> [TranslationHistory]{
        
        let historyItems = persistenceController.fetchTranslationHistory()
        let translationHistoryArray: [TranslationHistory] = historyItems.map { historyItem in
            return TranslationHistory(
                date: historyItem.date!,
                type: historyItem.type!,
                topic: historyItem.topic!,
                originalText: historyItem.originalText!,
                translatedText: historyItem.translatedText!
            )
        }
        return translationHistoryArray
    }
    
    //MARK: - Reload all history to get up-to-date info
    func reloadTranslationHistory(){
        self.translationHistoryArray = fetchTranslationHistory()
    }
    
    //MARK: - Delete translation history based on the data from the row used selected
    func deleteTranslationHistory(_ history: TranslationHistory) {
        persistenceController.deleteTranslationHistory(translationHistory: history)
    }
    
    //MARK: - Update data entry for specific translation history
    func updateTrasnlationHistory(history:TranslationHistory, editedDate:Date, editedTopic:String, editedType:String){
        persistenceController.updateTrasnlationHistory(history: history, editedDate: editedDate, editedTopic: editedTopic, editedType: editedType)
    }
}
