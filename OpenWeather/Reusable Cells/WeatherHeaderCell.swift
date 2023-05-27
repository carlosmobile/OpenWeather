//
//  WeatherHeaderCell.swift
//  OpenWeather
//
//  Created by Carlos on 27/5/23.
//

import UIKit

class WeatherHeaderCell: UITableViewCell {

    let cityLabel = UILabel()
    let temperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set any attributes of your UI components here.
        cityLabel.text = "Barcelona"
        cityLabel.font = UIFont.systemFont(ofSize: 25)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.text = "25"
        temperatureLabel.font = UIFont.systemFont(ofSize: 75)
        
        // Add the UI components
        contentView.addSubview(cityLabel)
        contentView.addSubview(temperatureLabel)
        cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cityLabel.heightAnchor.constraint(equalToConstant: 70),
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
