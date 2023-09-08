//
//  LinguaLinkApp.swift
//  LinguaLink
//
//  Created by Yan Hua on 8/9/2023.
//

import SwiftUI

@main
struct LinguaLinkApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
