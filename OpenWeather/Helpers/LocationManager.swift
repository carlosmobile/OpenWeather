//
//  LocationManager.swift
//  OpenWeather
//
//  Created by Carlos on 27/5/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    var isAuthorizedLocation: Bool = false
    
    public var exposedLocation: CLLocation? {
        return self.locationManager.location
    }
        
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
    
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            self.isAuthorizedLocation = true
        case .restricted, .denied:
            self.isAuthorizedLocation = false

        @unknown default:
            print("error")
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "isLocationChanged"), object: nil)
    }
}

extension LocationManager {
    
    func requestLocation() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}
