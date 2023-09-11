//
//  SettingView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 9/9/2023.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("darkModeEnabled") var darkModeEnabled = false
    @State private var autoTranslation = false
    @State private var temperature: Double = 0.7
    @State private var maxTokens: Int = 50
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Toggle("Auto-Translation", isOn: $autoTranslation)
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
                    Picker("Source Language", selection: .constant(0)) {
                        Text("English").tag(0)
                        Text("French").tag(1)
                        Text("Spanish").tag(2)
                    }
                    Picker("Target Language", selection: .constant(0)) {
                        Text("German").tag(0)
                        Text("Japanese").tag(1)
                        Text("Chinese").tag(2)
                    }
                }
                
                Section(header: Text("Google Translation")) {
                }
                
                Section(header: Text("ChatGPT Translation")) {
                    HStack {
                        Text("Variability")
                        Slider(value: $temperature, in: 0.1...1.0, step: 0.1)
                        Text("\(temperature, specifier: "%.1f")")
                    }
                    
                    HStack {
                        Text("Response Length")
                        Stepper(value: $maxTokens, in: 1...100, step: 1) {
                            Text("\(maxTokens)")
                        }
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
