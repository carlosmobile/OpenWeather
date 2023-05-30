//
//  APIRequest.swift
//  OpenWeather
//
//  Created by Carlos on 27/5/23.
//

import Foundation

class APIRequest {
    let method: HTTPMethod
    let path: String
    var body: Data?

    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
    }
}
