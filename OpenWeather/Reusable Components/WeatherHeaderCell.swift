//
//  WeatherHeaderCell.swift
//  OpenWeather
//
//  Created by Carlos on 27/5/23.
//

import UIKit

class WeatherHeaderCell: UITableViewCell {

    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cityLabel.font = UIFont.systemFont(ofSize: 25)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont.systemFont(ofSize: 75)
        
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
    
    func updateCell(withModel model: WeatherModel) {
        guard let firstHour = model.hourly.first else { return }
        cityLabel.text = model.city
        temperatureLabel.text = String(format: "%0.0f" + "°", firstHour.temp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
