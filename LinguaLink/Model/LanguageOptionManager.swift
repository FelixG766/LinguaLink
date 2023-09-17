//
//  LanguageOptionManager.swift
//  LinguaLink
//
//  Created by Yangru Guo on 10/9/2023.
//

import Foundation

struct LanguageOptionManager{
    
    //    Language option is a static file obtained from cloud.google.com/translate/docs/languages
    //    The list of language options is stored in a static JSON file
    //    More supported language can be incorporated by updating the JSON file in the future
    //    The relevant API for updating JSON file is
    //    cloud.google.com/translate/docs/basic/discovering-supported-languages#translate_list_codes-drest
    
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
