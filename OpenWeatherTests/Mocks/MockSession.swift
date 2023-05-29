//
//  MockSession.swift
//  OpenWeatherTests
//
//  Created by Carlos on 30/5/23.
//

import Foundation
@testable import OpenWeather

class MockSession: SessionProtocol {

    var dataTask = MockDataTask()
    var expectedData: Data?
    var expectedUrlResponse: URLResponse?
    var expectedError: Error?

    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskProtocol {
        completionHandler(expectedData, expectedUrlResponse, expectedError)
        return dataTask
    }
}

class MockDataTask: DataTaskProtocol {
    func resume() { }
}
