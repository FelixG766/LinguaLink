//
//  Constant.swift
//  LinguaLink
//
//  Created by Yangru Guo on 10/9/2023.
//

import Foundation

struct Constant{
    
    //MARK: - general default settings
    static let defaultTranslationProvider = GoogleCloudTranslationService()
    static let defaultSourceLanguage = "en"
    static let defaultTargetLanguage = "zh-CN"
    static let defaultTranslator = "GOOGLE"
    
    //MARK: - Google translation default settings
    struct GoogleAPI{
        static let baseURL = "https://translation.googleapis.com/language/translate/v2"
        static let apiKey = "AIzaSyDPEkqgFispeW6BpNgArcWPUityMiidVO4";
    }


}
