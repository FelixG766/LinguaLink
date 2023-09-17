//
//  LinguaLinkTests.swift
//  LinguaLinkTests
//
//  Created by Yangru Guo on 17/9/2023.
//

import XCTest

@testable import LinguaLink
import CoreData

final class TranslationHistoryViewModelTest: XCTestCase {
    
    var translationHistoryViewModel:TranslationHistoryViewModel!
    var persistentController:PersistenceController!

    override func setUpWithError() throws {
        translationHistoryViewModel = TranslationHistoryViewModel()
        persistentController = PersistenceController()
    }

    override func tearDownWithError() throws {
        // Clean up and release any resources or objects that were created during the setup of your test case.
        translationHistoryViewModel = nil
        persistentController = nil
        try super.tearDownWithError()
    }

    // Test deleting a translation history entry
    func testDeleteTranslationHistory() {
        // Create a sample translation history entry
        let history = TranslationHistory(date: Date(), type: "Word", topic: "Greeting", originalText: "Hello", translatedText:  "你好")
        
        // Add the history entry to your view model or persistence store
        persistentController.saveTranslationHistory(translationHistory: history)
        // Call the delete function
        translationHistoryViewModel.deleteTranslationHistory(history)

        // Assert that the history entry has been deleted or no longer exists
        
        XCTAssert(persistentController.fetchExactTranslationHistory(history: history) == nil)
    }

    // Test updating a translation history entry
    func testUpdateTranslationHistory(){
        // Create a sample translation history entry
        let history = TranslationHistory(date: Date(), type: "Word", topic: "Greeting", originalText: "Hello", translatedText:  "你好") // You should create a valid instance
        // Add the history entry to your view model or persistence store
        persistentController.saveTranslationHistory(translationHistory: history)
        // Define the edited data
        // Define the time interval (in seconds) to subtract from the current date
        let oneDay: TimeInterval = -86400 // 86400 seconds in a day
        let editedDate = Date(timeIntervalSinceNow: oneDay)
        let editedTopic = "Edited Topic"
        let editedType = "Edited Type"
        let editedHistoryEntry = TranslationHistory(date: editedDate, type: editedType, topic: editedTopic, originalText: history.originalText, translatedText: history.translatedText)

        // Call the update function
        translationHistoryViewModel.updateTrasnlationHistory(history: history, editedDate: editedDate, editedTopic: editedTopic, editedType: editedType)

        // Assert that the history entry has been updated correctly
        XCTAssert(persistentController.fetchExactTranslationHistory(history: editedHistoryEntry) != nil)
    }

}
