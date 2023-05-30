//
//  TestViewModels.swift
//  OpenWeatherTests
//
//  Created by Carlos 30/5/23.
//

import XCTest
@testable import OpenWeather

class TestViewModels: XCTestCase {
    
    func testWeatherViewModel() throws {
        let weatherViewModel = WeatherViewModel()
        
        let json = WeatherModelJSON
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        do {
            var weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
            weatherModel.city = "Alicante"
            weatherViewModel.weatherData.value = weatherModel
        } catch {
            XCTAssert(false)
        }
        
        weatherViewModel.isNecessaryToShowBottomLocationSheet.value = true
        weatherViewModel.isLoadingData.value = true
        weatherViewModel.isUpdateData = true
        weatherViewModel.footerSheetType = .locationAlert

        weatherViewModel.checkLocation()
        weatherViewModel.refreshWeatherData()
        let internetErrorControl = weatherViewModel.hasInternetConnection()
        weatherViewModel.setFooterSheetAlertNavigation()
        let coordinates = weatherViewModel.getLocationCoordinates()
        weatherViewModel.getLocationPlace(coordinates) { city in
            XCTAssertNotNil(city)
        }
        
        XCTAssertNotNil(coordinates)
        XCTAssertNotNil(internetErrorControl)
        XCTAssertEqual(weatherViewModel.isNecessaryToShowBottomLocationSheet.value, true)
        XCTAssertEqual(weatherViewModel.isLoadingData.value, true)
        XCTAssertEqual(weatherViewModel.isUpdateData, true)
        XCTAssertEqual(weatherViewModel.footerSheetType, .locationAlert)
    }
}
