//
//  ContentView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import SwiftUI
import CoreData

struct TranslationView: View {
    @ObservedObject var viewModel: TranslationViewModel
    
    @State private var inputText = ""
    @State private var sourceLanguage = "en"
    @State private var targetLanguage = "fr"
    @State private var translationStyle = "normal"
    @State private var horizontalPadding = 25.0
    @State private var translatedText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Spacer()
                HStack{
                    Text("LinguaLink")
                        .font(.custom("Avenir Next", size: 20))
                        .foregroundColor(.blue)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue.opacity(0.1))
                        )
                        .shadow(color: .gray, radius: 5, x: 0, y: 2) 
                    Spacer()
                    Button(action: {
                        print("Camera button tapped")
                    }) {
                        Image(systemName: "camera")
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, horizontalPadding)

                    Button(action: {
                        print("Microphone button tapped")
                    }) {
                        Image(systemName: "mic")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, horizontalPadding)
                
                TextEditor(text: $inputText)
                    .background(Color.clear)
                    .font(.body)
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.9), lineWidth: 1)
                    )
                    .padding(.horizontal, horizontalPadding)
                
                HStack{
                    
                    Picker("Source Language", selection: $sourceLanguage) {
                        Text("English").tag("en")
                        Text("French").tag("fr")
                        Text("Chinese").tag("zh")
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrowshape.right")
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Picker("Source Language", selection: $targetLanguage) {
                        Text("English").tag("en")
                        Text("French").tag("fr")
                        Text("Chinese").tag("zh")
                    }
                }
                .padding(.horizontal, horizontalPadding)
                
                
                
                Picker("Translation Style", selection: $translationStyle) {
                    Text("DEFAULT").tag("DEF")
                    Text("GOOGLE").tag("GOO")
                    Text("CHATGPT").tag("GPT")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, horizontalPadding)
                .foregroundColor(.primary)
                
                Button("Translate") {
                    viewModel.translateAndStore(inputText, from: sourceLanguage, to: targetLanguage)
                    inputText = ""
                }
                
                
                TextEditor(text: $translatedText)
                    .font(.body)
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.9), lineWidth: 1)
                    )
                    .padding(.horizontal, horizontalPadding)
                
                HStack{
                    Spacer()
                    Button(action: {
                        print("Camera button tapped")
                    }) {
                        Image(systemName: "speaker.wave.3")
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, horizontalPadding)

                    Button(action: {
                        print("Microphone button tapped")
                    }) {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, horizontalPadding)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = TranslationViewModel(translator: Translator())
        return TranslationView(viewModel: viewModel)
    }
}
