//
//  WeatherViewModel.swift
//  OpenWeather
//
//  Created by Carlos on 26/5/23.
//

import CoreLocation

class WeatherViewModel {
    
    
    init() {
        
    }
    
    func requestWeatherByLocation(lat: CLLocationDegrees, lon: CLLocationDegrees) {

        let server = Server()
        let urlServer = server.getWeatherURLByLocationWith(lat: lat, lon: lon)
        let getRequest = APIRequest(method: .get, path: urlServer)

        APIClient().perform(request: getRequest) { result in
            switch result {
            case .success(let response):
                if let response = try? response.decode(to: WeatherDataModel.self) {
                    print(response.body)
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
