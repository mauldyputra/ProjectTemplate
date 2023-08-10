//
//  CLLocation+Utilities.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import CoreLocation

class MapLocation {
    func getCurrentData(currentLocation: CLLocation, completion: ((CLPlacemark) -> Void)?) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks, _) -> Void in
            placemarks?.forEach { (placemark) in
                completion?(placemark)
            }
        })
    }
}
