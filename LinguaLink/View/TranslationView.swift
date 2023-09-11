//
//  ContentView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import SwiftUI
import CoreData

struct TranslationView: View {
    
    private let languageOptionManager = LanguageOptionManager()
    @ObservedObject var viewModel: TranslationViewModel
    @State private var inputText = ""
    @State private var sourceLanguage = Constant.defaultSourceLanguage
    @State private var targetLanguage = Constant.defaultTargetLanguage
    @State private var translationProvider = Constant.defaultTranslator
    @State private var horizontalPadding = 25.0
    @State private var translatedText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Spacer()
                //MARK: - Top Row
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
                
                //MARK: - Input Text Field
                TextEditor(text: $inputText)
                    .background(Color.clear)
                    .font(.body)
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.9), lineWidth: 1)
                    )
                    .padding(.horizontal, horizontalPadding)
                
                //MARK: - Language Options Row
                HStack{
                    
                    Picker("Source Language", selection: $sourceLanguage) {
                        ForEach(languageOptionManager.loadLanguageOptions(), id: \.self) { option in
                            Text(option.name)
                                .tag(option.code)
                                .lineLimit(1)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Picker("Source Language", selection: $targetLanguage) {
                        ForEach(languageOptionManager.loadLanguageOptions(), id: \.self) { option in
                            Text(option.name)
                                .tag(option.code)
                                .lineLimit(1)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, horizontalPadding)
                
                
                //MARK: - Different Translation Model
                Picker("Translation Style", selection: $translationProvider) {
                    Text("GOOGLE").tag("GOOGLE")
                    Text("CHATGPT").tag("CHATGPT")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, horizontalPadding)
                .foregroundColor(.primary)
                
                //MARK: - Manual Translate Button
                Button("Translate") {
                    viewModel.translateWithSelectedModel(inputText, from: sourceLanguage, to: targetLanguage, with: translationProvider)
                }
                
                //MARK: - Output Text Field
                TextEditor(text: $viewModel.translation)
                    .font(.body)
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.9), lineWidth: 1)
                    )
                    .padding(.horizontal, horizontalPadding)
                
                //MARK: - Audio Assistence and Save
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
        let viewModel = TranslationViewModel()
        return TranslationView(viewModel: viewModel)
    }
}
