//
//  Localized+String.swift
//  OpenWeather
//
//  Created by Carlos on 29/5/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
