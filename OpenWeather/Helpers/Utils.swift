//
//  Utils.swift
//  OpenWeather
//
//  Created by Carlos on 28/5/23.
//

import UIKit

func getHourFromOpenWeatherHourlyDT(dt: Int) -> String {
    let date = NSDate(timeIntervalSince1970: TimeInterval(dt))
    let formatter = DateFormatter()
    formatter.dateFormat = "h a"
    return formatter.string(from: date as Date)
}

func getIconURLFromIconName(icon: String) -> URL {
    guard let iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else { return URL(fileURLWithPath: "") }
    return iconURL
}
