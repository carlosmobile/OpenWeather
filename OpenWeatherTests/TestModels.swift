//
//  TestModels.swift
//  OpenWeatherTests
//
//  Created by Carlos 30/5/23.
//

import XCTest
@testable import OpenWeather

class TestModels: XCTestCase {

    func testWeatherModelDecoding() throws {

        let json = WeatherModelJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            var weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
            weatherModel.city = "Alicante"
            XCTAssertEqual(weatherModel.city, "Alicante")
            XCTAssertNotNil(weatherModel.hourly)
        } catch {
            XCTAssert(false)
        }
    }

    func testWeatherHourlyDecoding() throws {

        let json = WeatherHourlyJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let weatherHourly = try JSONDecoder().decode(WeatherHourly.self, from: data)
            XCTAssertEqual(weatherHourly.temp, 24.06)
            XCTAssertEqual(weatherHourly.time, 1685448000)
            XCTAssertNotNil(weatherHourly.weatherDetail)
        } catch {
            XCTAssert(false)
        }
    }

    func testWeatherDetailDecoding() throws {

        let json = WeatherDetailJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            let weatherDetail = try JSONDecoder().decode(WeatherDetail.self, from: data)
            XCTAssertEqual(weatherDetail.weatherDescription, "muy nuboso")
            XCTAssertEqual(weatherDetail.icon, "04n")
        } catch {
            XCTAssert(false)
        }
    }
}
