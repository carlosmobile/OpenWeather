//
//  FooterSheetView.swift
//  OpenWeather
//
//  Created by Carlos on 28/5/23.
//

import UIKit

class FooterSheetView: UIView {
    
    var shouldSetupConstraints = true
    
    private let titleLabel = UILabel()
    private lazy var loginButton = UIButton()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        titleLabel.text = "Por favor, da permisos a la localización"
        titleLabel.textColor = .white
        loginButton.setTitle("Ir a settings", for: .normal)
        
        self.addSubview(titleLabel)
        self.addSubview(loginButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            loginButton.heightAnchor.constraint(equalToConstant: 70)
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
