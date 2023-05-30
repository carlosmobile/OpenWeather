//
//  FooterSheetView.swift
//  OpenWeather
//
//  Created by Carlos on 28/5/23.
//

import UIKit

class FooterSheetView: UIView {
    
    private let buttonTopOffet: CGFloat = 10
    private let titleLabelBorderOffset: CGFloat = 20
    private let heightOffset: CGFloat = 70
    private let widthOffset: CGFloat = 140
    
    private let titleLabel = UILabel()
    private lazy var button = UIButton()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        titleLabel.text = "authorizedLocation".localized
        titleLabel.textColor = ThemeColor.black.OWColor
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        button.setTitle("goSettings".localized, for: .normal)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
