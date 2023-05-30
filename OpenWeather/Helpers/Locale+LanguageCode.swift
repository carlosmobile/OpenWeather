//
//  Locale+LanguageCode.swift
//  OpenWeather
//
//  Created by Carlos on 29/5/23.
//

import Foundation

extension Locale {
    static var preferredLanguageCode: String {
        guard let preferredLanguage = preferredLanguages.first,
              let code = Locale(identifier: preferredLanguage).languageCode else {
            return "en"
        }
        if code != "es" && code != "en" {
            return "en"
        }
        return code
    }
}
