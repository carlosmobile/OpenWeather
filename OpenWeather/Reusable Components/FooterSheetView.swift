//
//  FooterSheetView.swift
//  OpenWeather
//
//  Created by Carlos on 28/5/23.
//

import UIKit

class FooterSheetView: UIView {
        
    private let titleLabel = UILabel()
    private lazy var loginButton = UIButton()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        titleLabel.text = "authorizedLocation".localized
        titleLabel.textColor = .white
        loginButton.setTitle("goSettings".localized, for: .normal)
        
        self.addSubview(titleLabel)
        self.addSubview(loginButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            loginButton.heightAnchor.constraint(equalToConstant: 70),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    public var buttonTargetAction: (Any, Selector)? {
        didSet {
            if let targetAction = buttonTargetAction {
                self.loginButton.addTarget(targetAction.0, action: targetAction.1, for: .touchUpInside)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
