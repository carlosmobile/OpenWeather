//
//  APIConfiguration.swift
//  OpenWeather
//
//  Created by Carlos on 27/5/23.
//

import Foundation
import CoreLocation

struct Server {
    private let baseURL = "https://api.openweathermap.org/data/2.5/onecall?"
    private let apiKey = "7d2c7c24f231ae36b7a93b927c735d53"
    private let exclude = "daily,minutely,current,alerts"
    private let metric = "metric"
    
    func getWeatherURLByLocationWith(_ coordinates: CLLocation, language: String) -> String {
        let longitude = coordinates.coordinate.longitude
        let latitude = coordinates.coordinate.latitude
        let weatherURL = "\(baseURL)lat=\(latitude)&lon=\(longitude)&exclude=\(exclude)&units=\(metric)&appid=\(apiKey)&lang=\(language)"
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
