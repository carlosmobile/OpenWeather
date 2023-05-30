//
//  DefaultValues.swift
//  OpenWeatherTests
//
//  Created by Carlos on 30/5/23.
//

import XCTest
@testable import OpenWeather


// MARK: JSON Object
typealias JSON = [String : Any]

let WeatherModelJSON: JSON = [
    "hourly": [WeatherHourlyJSON]
]

let WeatherHourlyJSON: JSON = [
    "temp": 24.06,
    "dt": 1685448000,
    "weather": [WeatherDetailJSON]
]

let WeatherDetailJSON: JSON = [
    "description": "muy nuboso",
    "icon": "04n"
]

// MARK: Cloned Response
let OpenWeatherAPIResponse: JSON = [
    "results": WeatherModelJSON
]

// MARK: JSON Data

let OpenWeatherAPIRawJSON = """
        {
            "lat": 41.3874,
            "lon": 2.1686,
            "timezone": "Europe/Madrid",
            "timezone_offset": 7200,
            "hourly": [
                {
                    "dt": 1685448000,
                    "temp": 24.06,
                    "feels_like": 24.14,
                    "pressure": 1015,
                    "humidity": 62,
                    "dew_point": 16.33,
                    "uvi": 8.04,
                    "clouds": 32,
                    "visibility": 10000,
                    "wind_speed": 3.34,
                    "wind_deg": 169,
                    "wind_gust": 2.58,
                    "weather": [
                        {
                            "id": 802,
                            "main": "Clouds",
                            "description": "nubes dispersas",
                            "icon": "03d"
                        }
                    ],
                    "pop": 0.01
                },
                {
                    "dt": 1685451600,
                    "temp": 24.51,
                    "feels_like": 24.69,
                    "pressure": 1015,
                    "humidity": 64,
                    "dew_point": 17.26,
                    "uvi": 6.14,
                    "clouds": 20,
                    "visibility": 10000,
                    "wind_speed": 3.4,
                    "wind_deg": 174,
                    "wind_gust": 2.93,
                    "weather": [
                        {
                            "id": 801,
                            "main": "Clouds",
                            "description": "algo de nubes",
                            "icon": "02d"
                        }
                    ],
                    "pop": 0.19
                },
                {
                    "dt": 1685455200,
                    "temp": 24.13,
                    "feels_like": 24.22,
                    "pressure": 1015,
                    "humidity": 62,
                    "dew_point": 16.4,
                    "uvi": 4.94,
                    "clouds": 30,
                    "visibility": 10000,
                    "wind_speed": 3.29,
                    "wind_deg": 174,
                    "wind_gust": 2.86,
                    "weather": [
                        {
                            "id": 802,
                            "main": "Clouds",
                            "description": "nubes dispersas",
                            "icon": "03d"
                        }
                    ],
                    "pop": 0.2
                },
                {
                    "dt": 1685458800,
                    "temp": 23.65,
                    "feels_like": 23.66,
                    "pressure": 1015,
                    "humidity": 61,
                    "dew_point": 15.69,
                    "uvi": 3.41,
                    "clouds": 40,
                    "visibility": 10000,
                    "wind_speed": 3.09,
                    "wind_deg": 179,
                    "wind_gust": 2.88,
                    "weather": [
                        {
                            "id": 802,
                            "main": "Clouds",
                            "description": "nubes dispersas",
                            "icon": "03d"
                        }
                    ],
                    "pop": 0.2
                },
                {
                    "dt": 1685462400,
                    "temp": 23.02,
                    "feels_like": 22.97,
                    "pressure": 1014,
                    "humidity": 61,
                    "dew_point": 15.1,
                    "uvi": 2.21,
                    "clouds": 51,
                    "visibility": 10000,
                    "wind_speed": 2.91,
                    "wind_deg": 192,
                    "wind_gust": 2.98,
                    "weather": [
                        {
                            "id": 803,
                            "main": "Clouds",
                            "description": "muy nuboso",
                            "icon": "04d"
                        }
                    ],
                    "pop": 0.22
                },
                {
                    "dt": 1685466000,
                    "temp": 22.19,
                    "feels_like": 22.08,
                    "pressure": 1014,
                    "humidity": 62,
                    "dew_point": 14.57,
                    "uvi": 0.99,
                    "clouds": 59,
                    "visibility": 10000,
                    "wind_speed": 2.35,
                    "wind_deg": 209,
                    "wind_gust": 2.57,
                    "weather": [
                        {
                            "id": 500,
                            "main": "Rain",
                            "description": "lluvia ligera",
                            "icon": "10d"
                        }
                    ],
                    "pop": 0.22,
                    "rain": {
                        "1h": 0.24
                    }
                }
            ]
        }
""".data(using: .utf8)!
