//
//  TranslationHistoryView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 9/9/2023.
//

import SwiftUI

struct TranslationHistoryView: View {
    
    @ObservedObject var translationHistoryViewModel = TranslationHistoryViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(translationHistoryViewModel.translationHistoryArray, id: \.self) { history in
                    ZStack{
                        TranslationHistoryCellView(history: history)
                        NavigationLink(destination: TranslationHistoryDetailView(history: history, translationHistoryViewModel: translationHistoryViewModel)) {
                        }
                    }
                }
                .onDelete { indexSet in
                    // Delete the selected items from the database
                    let indicesToDelete = Array(indexSet)
                    for index in indicesToDelete {
                        let historyToDelete = translationHistoryViewModel.translationHistoryArray[index]
                        translationHistoryViewModel.deleteTranslationHistory(historyToDelete)
                    }
                }
            }
            .navigationTitle("History")
        }
        .onAppear{
            translationHistoryViewModel.reloadTranslationHistory()
            print("data reloaded")
        }
    }
}

struct TranslationHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationHistoryView()
    }
}
