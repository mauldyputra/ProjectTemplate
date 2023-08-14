//
//  BaseController+Location.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 11/08/23.
//

import CoreLocation

extension BaseController {
    @objc func locationRequestUsage(delegate: CLLocationManagerDelegate?, startUpdating update: Bool) {
        let status = CLLocationManager.authorizationStatus()

        // Handle each case of location permissions
        switch status {
            case .authorizedAlways:
                locationManager.requestAlwaysAuthorization()
            case .denied:
                locationManager.requestWhenInUseAuthorization()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                locationManager.requestWhenInUseAuthorization()
            default:
                print("location permission has been authorized")
        }
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = delegate
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                if update {
                    self.locationManager.requestLocation()
                }
            }
        }
    }
    
    func locationClearDelegate() {
        locationManager.delegate = nil
    }
}

extension CLLocation {
    func placemark(locale: Locale? = Locale(identifier: "id_ID") ,completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self, preferredLocale: locale) { completion($0?.first, $1) }
    }
}
