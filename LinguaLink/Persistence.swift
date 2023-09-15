//
//  Persistence.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = HistoryItem(context: viewContext)
            newItem.date = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LinguaLink")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    
    func saveTranslationHistory(translationHistory:TranslationHistory){
        let context = PersistenceController.shared.container.viewContext
        let newItem = HistoryItem(context: context)
        newItem.date = translationHistory.date
        newItem.topic = translationHistory.topic
        newItem.type = translationHistory.type
        newItem.originalText = translationHistory.originalText
        newItem.translatedText = translationHistory.translatedText
        
        do {
            try context.save()
            print("saved")
        } catch {
            print(error)
        }
    }
    
    func fetchTranslationHistory() -> [HistoryItem]{
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest:NSFetchRequest<HistoryItem> = HistoryItem.fetchRequest()
        
        do{
            let historyItems = try context.fetch(fetchRequest)
            return historyItems
        }catch{
            print(error)
        }
        return []
    }
    
    
}
