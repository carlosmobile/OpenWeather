//
//  WeatherHourlyCell.swift
//  WeatherHourlyCell
//
//  Created by Carlos on 26/5/23.
//

import UIKit

class WeatherHourlyCell: UICollectionViewCell {
    
    private let temperatureLabelFontSize: CGFloat = 18
    private let weatherTimeLabelFontSize: CGFloat = 14
    private let weatherDescriptionLabelFontSize: CGFloat = 12
    private let defaultBorderOffset: CGFloat = 5
    private let weatherDescriptionTopOffset: CGFloat = 10
    private let weatherTimeTopOffset: CGFloat = 15
    private let iconWeatherImageViewHeightConstant: CGFloat = 60
    private let backgroundCellViewCornerRadius: CGFloat = 8.0
    private let backgroundCellViewShadowRadius: CGFloat = 5.0
    
    private let weatherTimeLabel = UILabel()
    private let weatherDescriptionLabel = UILabel()
    private let iconWeatherImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let backgroundCellView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    func configureUI() {
        
        temperatureLabel.font = UIFont.systemFont(ofSize: temperatureLabelFontSize)
        weatherTimeLabel.font = UIFont.systemFont(ofSize: weatherTimeLabelFontSize)
        weatherDescriptionLabel.font = UIFont.systemFont(ofSize: weatherDescriptionLabelFontSize)
        weatherDescriptionLabel.textAlignment = .center
        
        contentView.addSubview(backgroundCellView)
        backgroundCellView.addSubview(weatherTimeLabel)
        backgroundCellView.addSubview(weatherDescriptionLabel)
        backgroundCellView.addSubview(iconWeatherImageView)
        backgroundCellView.addSubview(temperatureLabel)
        backgroundCellView.backgroundColor = ThemeColor.white.OWColor
        
        backgroundCellView.layer.cornerRadius = backgroundCellViewCornerRadius
        backgroundCellView.layer.borderWidth = 0.0
        backgroundCellView.layer.shadowColor = ThemeColor.grayLight.OWColor.cgColor
        backgroundCellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCellView.layer.shadowRadius = backgroundCellViewShadowRadius
        backgroundCellView.layer.shadowOpacity = 0.7
        backgroundCellView.layer.masksToBounds = false
        
        backgroundCellView.translatesAutoresizingMaskIntoConstraints = false
        weatherTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        iconWeatherImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: defaultBorderOffset),
            backgroundCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: defaultBorderOffset),
            backgroundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultBorderOffset),
            backgroundCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: defaultBorderOffset),
            weatherTimeLabel.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: weatherTimeTopOffset),
            weatherTimeLabel.centerXAnchor.constraint(equalTo: backgroundCellView.centerXAnchor),
            iconWeatherImageView.topAnchor.constraint(equalTo: weatherTimeLabel.bottomAnchor, constant: defaultBorderOffset),
            iconWeatherImageView.heightAnchor.constraint(equalToConstant: iconWeatherImageViewHeightConstant),
            iconWeatherImageView.centerXAnchor.constraint(equalTo: backgroundCellView.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: iconWeatherImageView.bottomAnchor, constant: defaultBorderOffset),
            temperatureLabel.centerXAnchor.constraint(equalTo: backgroundCellView.centerXAnchor),
            weatherDescriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: weatherDescriptionTopOffset),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultBorderOffset),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: defaultBorderOffset),
        ])

    }
    
    func updateCell(withModel model: WeatherHourly) {
        temperatureLabel.text = String(format: "%0.0f" + "°", model.temp)
        
        guard let desc = model.weatherDetail.first?.weatherDescription else { return }
        weatherDescriptionLabel.text = desc.capitalizedSentence
        weatherTimeLabel.text = getHourFromOpenWeatherHourlyDT(dt: model.time)
        
        guard let icon = model.weatherDetail.first?.icon else { return }
        iconWeatherImageView.downloadImageWithThirdPartyLibrary(fromUrl: getIconURLFromIconName(icon: icon))
        iconWeatherImageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
