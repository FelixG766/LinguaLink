//
//  TranslationHistoryCellView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 14/9/2023.
//

import SwiftUI

struct TranslationHistoryCellView: View {
    let history: TranslationHistory

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                Text(history.compactDate)
                    .font(.subheadline)
                Spacer()
            }

            Text(history.topic)
                .font(.headline)
                .foregroundColor(.primary)

            Text(history.type)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(15) // Add padding to the whole cell
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 2)
    }
}

struct TranslationHistoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        @State var demoTrans = TranslationHistory(date: Date(), type: "meeting", topic: "environment", originalText: "Hello", translatedText: "Hej")
        TranslationHistoryCellView(history: demoTrans).previewLayout(.sizeThatFits)
    }
}
