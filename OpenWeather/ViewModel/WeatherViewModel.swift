//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Carlos on 26/5/23.
//

import CoreLocation

class WeatherViewModel {
    
    var weatherData = Bindable<WeatherModel>()
    var isNecessaryToShowBottomLocationSheet = Bindable<Bool>()
    private let locationManager = LocationManager()
    
    init() {
        NotificationCenter.default.addObserver(self,
                         selector: #selector(checkLocation),
                         name: Notification.Name(rawValue: "isLocationChanged"),
                         object: nil)
        checkLocation()
    }
    
    @objc func checkLocation() {
        if locationManager.isAuthorizedLocation {
            let coordinates = getLocationCoordinates()
            fetchWeatherByLocation(lat: coordinates.coordinate.latitude, lon: coordinates.coordinate.longitude)
        }
        isNecessaryToShowBottomLocationSheet.value = !locationManager.isAuthorizedLocation
        print("aaa \(String(describing: isNecessaryToShowBottomLocationSheet.value))")
    }
    
    func getLocationCoordinates() -> CLLocation {
        guard let exposedLocation = self.locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return CLLocation(latitude: 0.0, longitude: 0.0)
        }
        return exposedLocation
    }
    
    func getLocationPlace(lat: CLLocationDegrees, lon: CLLocationDegrees) -> String {
        
        var locationPlace = ""
        
        self.locationManager.getPlace(for: CLLocation(latitude: lat, longitude: lon)) { placemark in
            guard let placemark = placemark else { return }
            
            var output = "Our location is:"
            if let country = placemark.country {
                output = output + "\n\(country)"
            }
            if let state = placemark.administrativeArea {
                output = output + "\n\(state)"
            }
            if let town = placemark.locality {
                output = output + "\n\(town)"
            }
            locationPlace = output
        }
        
        return locationPlace
    }
    
    func fetchWeatherByLocation(lat: CLLocationDegrees, lon: CLLocationDegrees) {

        let url = Server().getWeatherURLByLocationWith(latitude: lat, longitude: lon, language: "es")
        let getRequest = APIRequest(method: .get, path: url)

        APIClient().perform(request: getRequest) { result in
            switch result {
            case .success(let response):
                if let response = try? response.decode(to: WeatherModel.self) {
                    var responseData = WeatherModel(hourly: [])
                    responseData.city = self.getLocationPlace(lat: lat, lon: lon)
                    responseData.hourly = response.body.hourly
                    self.weatherData.value = responseData
                    print("aaa changed weather data fetch")
//                    print(response.body)
                }
                else {
                    if response.statusCode == 401 {
                        print("invalidCredentials")
                    } else {
                        print("errorDecodeResponse")
                    }
                }
            case .failure:
                print("failure")
            }
        }

    }
}
