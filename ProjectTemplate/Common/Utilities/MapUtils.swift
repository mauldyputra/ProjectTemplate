//
//  MapUtils.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

public final class MapsUtils {
    static func openAppleMaps(latitude: Float, longitude: Float, placeName: String?) {
        var url = "http://maps.apple.com/maps?ll=\(latitude),\(longitude)"
        if let p = placeName { url += "&q=\(p.toQueryFormat)" }
        
        UIApplication.shared.open(URL(string:url)!)
    }
    
    static func openGoogleMaps(latitude: Float, longitude: Float, shouldOpenAppleMapsOnFail openAppleMaps: Bool = false, placeName: String? = nil) {
        var url = "comgooglemaps://?center=\(latitude),\(longitude)&zoom=14"
        
        if latitude == 0.0 || longitude == 0.0 {
            url += "&q=\(placeName?.toQueryFormat ?? "")"
        } else {
            if let p = placeName { url += "&q=\(p.toQueryFormat)" }
            else { url += "&q=\(latitude),\(longitude)" }
        }
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(
                URL(string: url)!)
        } else {
            if openAppleMaps {
                MapsUtils.openAppleMaps(latitude: latitude, longitude: longitude, placeName: placeName)
            } else {
                Snackbar.showError("Google Maps tidak tersedia")
            }
        }
    }
}
