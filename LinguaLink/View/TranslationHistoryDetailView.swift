//
//  TranslationHistoryDetailView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 13/9/2023.
//

import SwiftUI

struct TranslationHistoryDetailView: View {
    
    let history: TranslationHistory
    var body: some View {
        List {
            Text("Detail View")
                .font(.title)
                .padding(.vertical,20)
            HStack{
                Text("Date:")
                Spacer()
                Text("\(history.compactDate)")
            }
            HStack{
                Text("Topic:")
                    .padding(.top,5)
                Spacer()
                Text("\(history.topic)")
            }
            HStack{
                Text("Type:")
                    .padding(.top,5)
                Spacer()
                Text("\(history.type)")
            }
            VStack{
                Text("Original Text:")
                    .padding(.top,5)
                Spacer()
                Text("\(history.originalText)")
            }
            VStack{
                Text("Translated Text:")
                    .padding(.top,5)
                Spacer()
                Text("\(history.translatedText)")
            }








            Spacer()
        }
    }
}

struct TranslationHistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationHistoryDetailView(history: TranslationHistory(date: Date(), type: "Meeting", topic: "Topic 1", originalText: "Text 1", translatedText: "Translated 1"))
    }
}
