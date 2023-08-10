//
//  TimeZoneUtilities.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation

public class TimeZoneUtilities {
    static func getTimeZone() -> String {
        let timezoneGmt = TimeZone.current.abbreviation()
        var timezoneName = ""
        if ((timezoneGmt?.contains("7")) == true) {
            timezoneName = "WIB"
        } else if ((timezoneGmt?.contains("8")) == true) {
            timezoneName = "WITA"
        } else {
            timezoneName = "WIT"
        }
        
        return timezoneName
    }
}
