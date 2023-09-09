//
//  MainView.swift
//  LinguaLink
//
//  Created by Yangru Guo on 8/9/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Group{
                TranslationView(viewModel: TranslationViewModel(translator: GoogleCloudTranslationService()))
                    .tabItem {
                        Image(systemName: "text.book.closed")
                        Text("Translate")
                    }
                
                TranslationHistoryView()
                    .tabItem {
                        Image(systemName: "clock")
                        Text("History")
                    }
                
                SettingView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .toolbarBackground(Color.gray.opacity(0.1), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
