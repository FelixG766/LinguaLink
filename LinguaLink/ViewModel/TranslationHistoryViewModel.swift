//
//  TranslationHistoryViewModel.swift
//  LinguaLink
//
//  Created by Yangru Guo on 14/9/2023.
//

import Foundation
import CoreData

class TranslationHistoryViewModel:ObservableObject {
    
    @Published var translationHistoryArray:[TranslationHistory] = []
    private var persistenceController = PersistenceController.shared
    
    init() {
        self.translationHistoryArray = fetchTranslationHistory()
    }
    
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
    
    func reloadTranslationHistory(){
        self.translationHistoryArray = fetchTranslationHistory()
    }
    
    func deleteTranslationHistory(_ history: TranslationHistory) {
        
        let context = persistenceController.container.viewContext
        
        let fetchRequest: NSFetchRequest<HistoryItem> = HistoryItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "date == %@ AND type == %@ AND topic == %@ AND originalText == %@ AND translatedText == %@",
            history.date as CVarArg,
            history.type,
            history.topic,
            history.originalText,
            history.translatedText
        )
        
        do {
            let matchingItems = try context.fetch(fetchRequest)
            
            if let itemToDelete = matchingItems.first {
                context.delete(itemToDelete)
                try context.save()
            }
        } catch {
            print("Error deleting history: \(error)")
        }
    }
    
    func updateTrasnlationHistory(history:TranslationHistory, editedDate:Date, editedTopic:String, editedType:String){
        
        let context = persistenceController.container.viewContext
        
        let fetchRequest: NSFetchRequest<HistoryItem> = HistoryItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "date == %@ AND type == %@ AND topic == %@ AND originalText == %@ AND translatedText == %@",
            history.date as CVarArg,
            history.type,
            history.topic,
            history.originalText,
            history.translatedText
        )
        
        do {
            let fetchedItems = try context.fetch(fetchRequest)
            if let existingItem = fetchedItems.first {
                // Modify the properties of the existing item with new values
                existingItem.date = editedDate
                existingItem.type = editedType
                existingItem.topic = editedTopic
                // Save the changes
                try context.save()
            }
        } catch {
            print(error)
        }
        
    }
}
