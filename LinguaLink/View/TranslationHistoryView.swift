//
//  TranslationHistoryView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 9/9/2023.
//

import SwiftUI

struct TranslationHistoryView: View {
    var body: some View {
        NavigationView {
            List(translationHistoryArray) { history in
                NavigationLink(destination: TranslationHistoryDetailView(history: history)) {
                    VStack(alignment: .leading) {
                        HStack{
                            Image(systemName: "calendar")
                            Spacer()
                            Text("Date: \(history.compactDate))")
                                .font(.headline)
                        }
                        .padding(.bottom, 10)
                        HStack{
                            Text("Topic:")
                                .padding(.bottom,5)
                            Spacer()
                            Text("\(history.topic)")
                        }
                        HStack{
                            Text("Type:")
                                .padding(.bottom,5)
                            Spacer()
                            Text("\(history.type)")
                        }

                    }
                }
            }
            .navigationTitle("Translation History")
        }
    }
}

struct TranslationHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationHistoryView()
    }
}
