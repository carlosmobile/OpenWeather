//
//  SubclassedCollectionViewCell.swift
//  ProgrammaticUICollectionView
//
//  Created by Steven Curtis on 13/11/2020.
//

import UIKit

class WeatherHourlyCell: UICollectionViewCell {
    
    private let weatherTime = UILabel()
    private let weatherDescription = UILabel()
    private let iconWeatherImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let backgroundCellView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    func configureUI() {
        
        temperatureLabel.font = UIFont.systemFont(ofSize: 18)
        weatherTime.font = UIFont.systemFont(ofSize: 14)
        weatherDescription.font = UIFont.systemFont(ofSize: 12)
        weatherDescription.textAlignment = .center
        
        contentView.addSubview(backgroundCellView)
        backgroundCellView.addSubview(weatherTime)
        backgroundCellView.addSubview(weatherDescription)
        backgroundCellView.addSubview(iconWeatherImageView)
        backgroundCellView.addSubview(temperatureLabel)

        backgroundCellView.backgroundColor = .white
        
        backgroundCellView.layer.cornerRadius = 8.0
        backgroundCellView.layer.borderWidth = 0.0
        backgroundCellView.layer.shadowColor = UIColor.lightGray.cgColor
        backgroundCellView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundCellView.layer.shadowRadius = 5.0
        backgroundCellView.layer.shadowOpacity = 1
        backgroundCellView.layer.masksToBounds = false
        
        backgroundCellView.translatesAutoresizingMaskIntoConstraints = false
        weatherTime.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        iconWeatherImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            backgroundCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            backgroundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            backgroundCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
            weatherTime.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: 15),
            weatherTime.centerXAnchor.constraint(equalTo: backgroundCellView.centerXAnchor),
            iconWeatherImageView.topAnchor.constraint(equalTo: weatherTime.bottomAnchor, constant: 5),
            iconWeatherImageView.heightAnchor.constraint(equalToConstant: 60),
            iconWeatherImageView.centerXAnchor.constraint(equalTo: backgroundCellView.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: iconWeatherImageView.bottomAnchor, constant: 5),
            temperatureLabel.centerXAnchor.constraint(equalTo: backgroundCellView.centerXAnchor),
            weatherDescription.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            weatherDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            weatherDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
            weatherDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

    }
    
    func updateCell(withModel model: WeatherHourly) {
        temperatureLabel.text = String(format: "%0.0f" + "°", model.temp)
        guard let desc = model.weatherDetail.first?.weatherDescription else { return }
        weatherDescription.text = desc.capitalized
        weatherTime.text = getHourFromOpenWeatherHourlyDT(dt: model.time)
        guard let icon = model.weatherDetail.first?.icon else { return }
        iconWeatherImageView.downloadImageWithThirdPartyLibrary(fromUrl: getIconURLFromIconName(icon: icon))
        iconWeatherImageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
