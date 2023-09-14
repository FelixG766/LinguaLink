//
//  TranslationHistoryView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 9/9/2023.
//

import SwiftUI

struct TranslationHistoryView: View {
    
    @ObservedObject var translationHistoryViewModel = TranslationHistoryViewModel()
    @State private var isDetailViewPresented = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(translationHistoryViewModel.translationHistoryArray, id: \.self) { history in
                    NavigationLink(destination: TranslationHistoryDetailView(history: history, translationHistoryViewModel: translationHistoryViewModel,isDetailViewPresented: $isDetailViewPresented)) {
                        TranslationHistoryCellView(history: history)
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
            translationHistoryViewModel.updateTranslationHistory()
        }
    }
}

struct TranslationHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationHistoryView()
    }
}
