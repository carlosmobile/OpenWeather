//
//  WeatherViewController.swift
//  OpenWeather
//
//  Created by Carlos on 26/5/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    var viewModel: WeatherViewModel = WeatherViewModel()
    
    let locationManager = CLLocationManager()
    let defaults = UserDefaults.standard
    let weatherTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(weatherTableView)
        view.backgroundColor = .white
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.backgroundColor = .red
        
        locationManager.delegate = self
        
        weatherTableView.register(WeatherHeaderCell.self, forCellReuseIdentifier: "WeatherHeaderCell")
        
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weatherTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        if let lat = defaults.object(forKey: "latitude") as? Double{
            if let lon = defaults.object(forKey: "longitude") as? Double {
                viewModel.requestWeatherByLocation(lat: lat, lon: lon)
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
    }

}

//MARK: - UITableView Configuration

enum Table: Int, CaseIterable {
  case WeatherHeader
  case WeatherByHours
}

//MARK: - UITableViewDataSource

extension WeatherViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Table.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()

        switch indexPath.section {
        case Table.WeatherHeader.rawValue:
            guard let characterListCell = tableView.dequeueReusableCell(withIdentifier: "WeatherHeaderCell") as? WeatherHeaderCell else {
                return cell
            }
            return characterListCell
        case Table.WeatherByHours.rawValue:
            return cell
        default:
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension WeatherViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("tapped")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200//UITableView.automaticDimension
    }
}
 
// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            self.defaults.set(lat, forKey: "latitude")
            self.defaults.set(lon, forKey: "longitude")
            viewModel.requestWeatherByLocation(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }

}
