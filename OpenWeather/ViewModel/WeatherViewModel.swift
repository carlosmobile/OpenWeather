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
    var isLoadingData = Bindable<Bool>()
    private let locationManager = LocationManager()
    
    init() {
        NotificationCenter.default.addObserver(self,
                         selector: #selector(checkLocation),
                         name: Notification.Name(rawValue: "isLocationChanged"),
                         object: nil)
        checkLocation()
    }
    
    @objc func checkLocation() {
        guard let isAuthorizedLocation = locationManager.isAuthorizedLocation else { return }
        
        if isAuthorizedLocation {
            let coordinates = getLocationCoordinates()
            isLoadingData.value = true
            getLocationPlace(coordinates) { [self] city in
                fetchWeatherByLocation(coordinates, city: city, language: Locale.preferredLanguageCode)
            }
        }
        
        isNecessaryToShowBottomLocationSheet.value = !isAuthorizedLocation
    }
    
    func getLocationCoordinates() -> CLLocation {
        guard let exposedLocation = self.locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return CLLocation(latitude: 0.0, longitude: 0.0)
        }
        return exposedLocation
    }
    
    func getLocationPlace(_ coordinates: CLLocation, completion: @escaping (String) -> Void) {
        self.locationManager.getPlace(for: CLLocation(latitude: coordinates.coordinate.latitude,
                                                      longitude: coordinates.coordinate.longitude)) { placemark in
            guard let placemark = placemark else { return }

            if let town = placemark.locality {
                completion(town)
            }
        }
    }
    
//MARK: - Openweather API request
    
    func fetchWeatherByLocation(_ coordinates: CLLocation, city: String, language: String) {

        let url = Server().getWeatherURLByLocationWith(coordinates, language: language)
        let getRequest = APIRequest(method: .get, path: url)

        APIClient().perform(request: getRequest) { result in
            switch result {
            case .success(let response):
                if let response = try? response.decode(to: WeatherModel.self) {
                    var responseData = WeatherModel(hourly: [])
                    responseData.city = city
                    responseData.hourly = response.body.hourly
                    self.weatherData.value = responseData
                    DispatchQueue.main.async {
                        self.isLoadingData.value = false
                    }
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
