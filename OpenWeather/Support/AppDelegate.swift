//
//  AppDelegate.swift
//  OpenWeather
//
//  Created by Carlos on 26/5/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = WeatherViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
