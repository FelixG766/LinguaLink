//
//  TranslationHistoryCellView.swift
//  LinguaLink
//
//  Created by Yan Hua on 14/9/2023.
//

import SwiftUI

struct TranslationHistoryCellView: View {
    let history:TranslationHistory
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "calendar")
                Spacer()
                Text(history.compactDate)
                    .font(.headline)
            }
            HStack{
                Text(history.topic)
                    .padding(.vertical,1)
            }
            HStack{
                Text(history.type)
            }
        }
    }
}

struct TranslationHistoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        TranslationHistoryCellView(history: translationHistoryArray[0]).previewLayout(.sizeThatFits)
    }
}
