//
//  FooterSheetView.swift
//  OpenWeather
//
//  Created by Carlos on 28/5/23.
//

import UIKit

enum AlertFooterSheetType {
    case internetAlert
    case locationAlert
}

class FooterSheetView: UIView {
    
    private let buttonTopOffet: CGFloat = 10
    private let titleLabelBorderOffset: CGFloat = 20
    private let heightOffset: CGFloat = 70
    private let widthOffset: CGFloat = 140
    
    let titleLabel = UILabel()
    lazy var button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.textColor = ThemeColor.black.OWColor
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        button.setTitleColor(ThemeColor.black.OWColor, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = ThemeColor.black.OWColor.cgColor
        button.layer.cornerRadius = 15
        
        self.backgroundColor = ThemeColor.white.OWColor
        
        self.addSubview(titleLabel)
        self.addSubview(button)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: titleLabelBorderOffset),
            titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: titleLabelBorderOffset),
            titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -titleLabelBorderOffset),
            titleLabel.heightAnchor.constraint(equalToConstant: heightOffset),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: buttonTopOffet),
            button.heightAnchor.constraint(equalToConstant: heightOffset),
            button.widthAnchor.constraint(equalToConstant: widthOffset),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    public var buttonTargetAction: (Any, Selector)? {
        didSet {
            if let targetAction = buttonTargetAction {
                self.button.addTarget(targetAction.0, action: targetAction.1, for: .touchUpInside)
            }
        }
    }
    
    public func configureFooterSheetTextWith(alertType: AlertFooterSheetType) {
        switch alertType {
        case AlertFooterSheetType.internetAlert:
            titleLabel.text = "connectionFailedMessage".localized
            button.setTitle("retry".localized, for: .normal)
        case AlertFooterSheetType.locationAlert:
            titleLabel.text = "authorizedLocation".localized
            button.setTitle("goSettings".localized, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
