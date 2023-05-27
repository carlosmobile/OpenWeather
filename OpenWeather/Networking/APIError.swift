//
//  APIError.swift
//  OpenWeather
//
//  Created by Carlos on 27/5/23.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailure
    case noInternet
}

