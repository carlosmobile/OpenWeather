//
//  SpinnerController.swift
//  OpenWeather
//
//  Created by Carlos on 28/5/23.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    private let titleLabelFontSize: CGFloat = 14
    private let titleLabelOffset: CGFloat = 15
    
    private let spinner = UIActivityIndicatorView(style: .gray)
    private let titleLabel = UILabel()

    override func loadView() {
        view = UIView()
        view.backgroundColor = ThemeColor.white.OWColor
        titleLabel.text = "loading".localized
        titleLabel.font = UIFont.systemFont(ofSize: titleLabelFontSize)
        titleLabel.textColor = ThemeColor.black.OWColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        spinner.color = .black

        spinner.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: titleLabelOffset),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -titleLabelOffset),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: titleLabelOffset)
        ])
    }
}
