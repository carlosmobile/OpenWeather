//
//  Utils.swift
//  OpenWeather
//
//  Created by Carlos on 28/5/23.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

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
