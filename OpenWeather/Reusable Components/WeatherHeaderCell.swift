//
//  WeatherHeaderCell.swift
//  OpenWeather
//
//  Created by Carlos on 27/5/23.
//

import UIKit

class WeatherHeaderCell: UITableViewCell {

    private let cityLabel = UILabel()
    private let iconWeatherImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let weatherDescription = UILabel()
    private let containerIconAndTempView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    func configureUI() {
        cityLabel.font = UIFont.systemFont(ofSize: 30)
        temperatureLabel.font = UIFont.systemFont(ofSize: 100)
        weatherDescription.font = UIFont.systemFont(ofSize: 20)

        contentView.addSubview(cityLabel)
        contentView.addSubview(containerIconAndTempView)
        containerIconAndTempView.addSubview(temperatureLabel)
        containerIconAndTempView.addSubview(iconWeatherImageView)
        contentView.addSubview(weatherDescription)
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        iconWeatherImageView.translatesAutoresizingMaskIntoConstraints = false
        containerIconAndTempView.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerIconAndTempView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerIconAndTempView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cityLabel.heightAnchor.constraint(equalToConstant: 70),
            weatherDescription.topAnchor.constraint(equalTo: containerIconAndTempView.bottomAnchor, constant: 5),
            containerIconAndTempView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            containerIconAndTempView.heightAnchor.constraint(equalToConstant: 90),
        ])
        
        iconWeatherImageView.setContentCompressionResistancePriority(temperatureLabel.contentCompressionResistancePriority(for: .horizontal) + 1, for: .horizontal)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "|[icon]-[lbl]|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: ["lbl": temperatureLabel, "icon": iconWeatherImageView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lbl]|", options: [], metrics: nil, views: ["lbl": iconWeatherImageView]))
    }
    
    func updateCell(withModel model: WeatherModel) {
        guard let firstHour = model.hourly.first else { return }
        cityLabel.text = model.city
        temperatureLabel.text = String(format: "%0.0f" + "°", firstHour.temp)
        guard let desc = firstHour.weatherDetail.first?.weatherDescription else { return }
        weatherDescription.text = desc.capitalized + "    " + getHourFromOpenWeatherHourlyDT(dt: firstHour.time)
        guard let icon = firstHour.weatherDetail.first?.icon else { return }
        iconWeatherImageView.load(url: getIconURLFromIconName(icon: icon))
        iconWeatherImageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
