//
//  APIConfiguration.swift
//  OpenWeather
//
//  Created by Carlos on 27/5/23.
//

import Foundation
import CoreLocation

struct Server {
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    private let apiKey = "7d2c7c24f231ae36b7a93b927c735d53"
    
    func getWeatherURLByLocationWith(lat: CLLocationDegrees, lon: CLLocationDegrees) -> String {
        let weatherURL = "\(baseURL)lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        return weatherURL
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct HTTPHeader {
    let field: String
    let value: String
}
