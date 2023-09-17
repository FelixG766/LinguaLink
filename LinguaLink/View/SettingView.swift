//
//  SettingView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 9/9/2023.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("darkModeEnabled") var darkModeEnabled = false
    @State private var temperature: Double = 0.7
    @State private var maxTokens: Int = 50
    @State private var sourceLanguage = UserDefaults.getValue(forKey: UserDefaults.sourceLanguageKey, defaultValue: AppDefaults.defaultSourceLanguage)
    @State private var targetLanguage = UserDefaults.getValue(forKey: UserDefaults.targetLanguageKey, defaultValue: AppDefaults.defaultTargetLanguage)
    @State private var translationStyle = UserDefaults.getValue(forKey: UserDefaults.translationStyleKey, defaultValue: AppDefaults.ChatGPT.translationStyle)
    private let languageOptionManager = LanguageOptionManager()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .onChange(of: darkModeEnabled){newVal in
                            
                            guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                                return
                            }
                            
                            guard let firstWindow = firstScene.windows.first else {
                                return
                            }
                            
                            if newVal {
                                // Enable Dark Mode
                                firstWindow.overrideUserInterfaceStyle = .dark
                            } else {
                                // Disable Dark Mode
                                firstWindow.overrideUserInterfaceStyle = .light
                            }
                        }
                }
                
                Section(header: Text("App Default")) {
                    Picker("Source Language", selection: $sourceLanguage) {
                        ForEach(languageOptionManager.loadLanguageOptions(), id: \.self) { option in
                            Text(option.name)
                                .tag(option.code)
                        }
                    }
                    .onChange(of: sourceLanguage) { newValue in
                        UserDefaults.standard.set(newValue, forKey: UserDefaults.sourceLanguageKey)
                    }
                    Picker("Target Language", selection: $targetLanguage) {
                        ForEach(languageOptionManager.loadLanguageOptions(), id: \.self) { option in
                            Text(option.name)
                                .tag(option.code)
                        }
                    }
                    .onChange(of: targetLanguage) { newValue in
                        UserDefaults.standard.set(newValue, forKey: UserDefaults.targetLanguageKey)
                    }
                }
                
                Section(header: Text("ChatGPT Translation")) {
                    Picker("Translation Style", selection: $translationStyle) {
                        ForEach(styleArray, id: \.self) { style in
                            Text(style).tag(style)
                        }
                    }
                    .onChange(of: translationStyle) { newValue in
                        UserDefaults.standard.set(newValue, forKey: UserDefaults.translationStyleKey)
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
