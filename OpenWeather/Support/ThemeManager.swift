//
//  ThemeManager.swift
//  OpenWeather
//
//  Created by Carlos on 30/5/23.
//

import UIKit

enum ThemeColor: Int {

    case `default`, white, cyan, grayLight, black

    var OWColor: UIColor {
        switch self {
        case .default:
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .white:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .cyan:
            return #colorLiteral(red: 0.4255025089, green: 0.7671470642, blue: 0.8935061693, alpha: 1)
        case .grayLight:
            return #colorLiteral(red: 0.8982589245, green: 0.8976286054, blue: 0.9194687009, alpha: 1)
        case .black:
            return #colorLiteral(red: 0.3205151558, green: 0.3291320801, blue: 0.3377395272, alpha: 1)
        }
    }
}
