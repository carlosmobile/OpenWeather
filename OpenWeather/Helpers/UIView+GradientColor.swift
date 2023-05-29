//
//  UIView+GradientColor.swift
//  OpenWeather
//
//  Created by Carlos on 29/5/23.
//

import UIKit

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0, 3.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
