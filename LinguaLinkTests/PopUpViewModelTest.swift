//
//  PopUpViewModelTest.swift
//  LinguaLinkTests
//
//  Created by Yangru Guo on 17/9/2023.
//

import XCTest
@testable import LinguaLink

final class PopUpViewModelTest: XCTestCase {

    var popUpViewModel:PopUpViewModel!
    var persistentController:PersistenceController!

    override func setUpWithError() throws {
        popUpViewModel = PopUpViewModel()
        persistentController = PersistenceController()
    }

    override func tearDownWithError() throws {
        // Clean up and release any resources or objects that were created during the setup of your test case.
        popUpViewModel = nil
        persistentController = nil
        try super.tearDownWithError()
    }

    func testSaveTranslationHistory() {
        
        let newTranslationHistory = TranslationHistory(date: Date(), type: "Word", topic: "Greeting", originalText: "Hello", translatedText:  "你好")
        
        popUpViewModel.saveTranslationHistory(date: newTranslationHistory.date, topic: newTranslationHistory.topic, type: newTranslationHistory.type, originalText: newTranslationHistory.originalText, translatedText: newTranslationHistory.translatedText)
        
        XCTAssert(persistentController.fetchExactTranslationHistory(history: newTranslationHistory) != nil)
    }

}
