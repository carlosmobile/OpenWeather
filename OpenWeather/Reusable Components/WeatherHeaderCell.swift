//
//  WeatherHeaderCell.swift
//  OpenWeather
//
//  Created by Carlos on 27/5/23.
//

import UIKit

class WeatherHeaderCell: UITableViewCell {
    
    private let weatherDescriptionTopOffset: CGFloat = 5
    private let containerIconAndTempViewLeadingOffset: CGFloat = 20
    private let cityLabelTopOffset: CGFloat = 20
    private let cityLabelHeightConstant: CGFloat = 90
    private let containerIconAndTempViewHeight: CGFloat = 120
    private let cityLabelFontSize: CGFloat = 36
    private let temperatureLabelFontSize: CGFloat = 110
    private let weatherDescriptionLabelFontSize: CGFloat = 24

    private let cityLabel = UILabel()
    private let iconWeatherImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let weatherDescriptionLabel = UILabel()
    private let containerIconAndTempView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    func configureUI() {
        cityLabel.font = UIFont.systemFont(ofSize: cityLabelFontSize)
        temperatureLabel.font = UIFont.systemFont(ofSize: temperatureLabelFontSize)
        weatherDescriptionLabel.font = UIFont.systemFont(ofSize: weatherDescriptionLabelFontSize)
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear

        contentView.addSubview(cityLabel)
        contentView.addSubview(containerIconAndTempView)
        containerIconAndTempView.addSubview(temperatureLabel)
        containerIconAndTempView.addSubview(iconWeatherImageView)
        contentView.addSubview(weatherDescriptionLabel)
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        iconWeatherImageView.translatesAutoresizingMaskIntoConstraints = false
        containerIconAndTempView.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerIconAndTempView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cityLabelTopOffset),
            cityLabel.heightAnchor.constraint(equalToConstant: cityLabelHeightConstant),
            weatherDescriptionLabel.topAnchor.constraint(equalTo: containerIconAndTempView.bottomAnchor, constant: weatherDescriptionTopOffset),
            containerIconAndTempView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            containerIconAndTempView.heightAnchor.constraint(equalToConstant: containerIconAndTempViewHeight),
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
        weatherDescriptionLabel.text = desc.capitalizedSentence + "    " + getHourFromOpenWeatherHourlyDT(dt: firstHour.time)
        guard let icon = firstHour.weatherDetail.first?.icon else { return }
        iconWeatherImageView.downloadImageWithThirdPartyLibrary(fromUrl: getIconURLFromIconName(icon: icon))
        iconWeatherImageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
