//
//  LanguageOptionManager.swift
//  LinguaLink
//
//  Created by Yan Hua on 10/9/2023.
//

import Foundation

struct LanguageOptionManager{
    
    struct LanguageOption: Codable,Hashable {
        let name: String
        let code: String
    }
    
    struct LanguageOptions: Codable {
        let languages: [LanguageOption]
    }
    
    func loadLanguageOptions() -> [LanguageOption] {
        if let url = Bundle.main.url(forResource: "LanguageOptions", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let options = try? JSONDecoder().decode(LanguageOptions.self, from: data) {
            return options.languages
        }
        return []
    }
    
}
