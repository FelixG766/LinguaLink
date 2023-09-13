//
//  File.swift
//  LinguaLink
//
//  Created by Yangru Guo on 12/9/2023.
//

import Foundation

class PopUpViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var topic = ""
    @Published var originalText = ""
    @Published var translatedText = ""
    @Published var type = ""
}
