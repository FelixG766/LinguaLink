//
//  ErrorCodeManager.swift
//  LinguaLink
//
//  Created by Yangru Guo on 17/9/2023.
//

import Foundation

enum ErrorCodes {
    static let failToConstructURLComponentsError = 1
    static let failToConstructURLError = 2
    static let failToGetDataFromGoogleAPI = 3
    static let failInJSONParsingOrTypeCasting = 4
    static let failToReceiveRespondFromChatGPT = 5
}
