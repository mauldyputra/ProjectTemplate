//
//  Date+Utilities.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import SwiftDate
import Foundation

// MARK: String Formats
extension Date {
    static var now: Date {
        return DateInRegion(Date(), region: SwiftDate.defaultRegion).date
    }
    
    static var usLocale: Locales {
        return Locales.englishUnitedStates
    }
    
    static var idLocale: Locales {
        return Locales.indonesianIndonesia
    }
    
    static var usRegion: Region {
        return Region(calendar: Calendars.gregorian, zone: Zones.americaNewYork, locale: Locales.english)
    }
    
    static var idRegion: Region {
        return Region(calendar: Calendars.gregorian, zone: Zones.asiaJakarta, locale: Locales.indonesian)
    }
    
    static var currentRegion: Region {
        return SwiftDate.defaultRegion
    }
    
    var isTodayInRegion: Bool {
        return self.in(region: Date.currentRegion).isToday
    }
    
    var toYearFirstFormat: String {
        let format = "yyyy-MM-dd"
        return self.toFormat(format, locale: Date.usLocale)
    }
    
    func toReadableTime(withHour hour: Bool = true, in locale: Locales? = nil) -> String {
        let format = hour ? "d MMM yyyy, HH:mm" : "d MMM yyyy"
        if let locale = locale {
            return self.toFormat(format, locale: locale)
        }
        return self.toString(.custom(format))
    }
    
    func toFullHumanTime(withHour hour: Bool = false, andTimeZone zone: Bool = false, in locale: Locales? = nil) -> String {
        var format = hour ? "EEEE, d MMMM yyyy, HH:mm" : "EEEE, d MMM yyyy"
        if zone {
            format += " zzz"
        }
        if let locale = locale {
            return self.toFormat(format, locale: locale)
        }
        return self.toString(.custom(format))
    }
    
    func toReadableTime12Hour() -> String {
        let format = "d MMMM yyyy, HH:mm"
        return self.toFormat(format, locale: Date.usLocale)
    }
    
    func toString(dateFormat: String = "dd-MM-yyyy", locale: Locale = Locale(identifier: "id_ID"), timezone : TimeZone? = TimeZone(abbreviation: "GMT+7"))->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = timezone
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
    }
    
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    
    func nearestHourRoundedUp() -> Date {
        return Date(timeIntervalSinceReferenceDate:
                        (timeIntervalSinceReferenceDate / 3600.0).rounded(.up) * 3600.0)
    }
}

extension DateInRegion {
    var toYearFirstFormat: String {
        let format = "yyyy-MM-dd"
        return self.toFormat(format, locale: Date.usLocale)
    }
    
    func toReadableTime(withHour hour: Bool = true, in locale: Locales? = nil) -> String {
        let format = hour ? "d MMM yyyy, HH:mm" : "d MMM yyyy"
        if let locale = locale {
            return self.toFormat(format, locale: locale)
        }
        return self.toString(.custom(format))
    }
    
    func toFullHumanTime(withHour hour: Bool = false, andTimeZone zone: Bool = false, in locale: Locales? = nil) -> String {
        var format = hour ? "EEEE, d MMMM yyyy, HH:mm" : "EEEE, d MMM yyyy"
        if zone {
            format += " zzz"
        }
        if let locale = locale {
            return self.toFormat(format, locale: locale)
        }
        return self.toString(.custom(format))
    }
    
    func toReadableTime12Hour() -> String {
        let format = "d MMMM yyyy, HH:mm"
        return self.toFormat(format, locale: Date.usLocale)
    }
}

extension Date {
    static func createTodayFromTime(time: Date) -> Date {
        return DateInRegion(components: {
            $0.year = Date.now.year
            $0.month = Date.now.month
            $0.day = Date.now.day
            $0.hour = time.hour
            $0.minute = time.minute
            $0.second = time.second
        }, region: Date.currentRegion)!.date
    }
    
    static func createTodayFromTimeInRegion(time: DateInRegion) -> Date {
        return DateInRegion(components: {
            $0.year = Date.now.year
            $0.month = Date.now.month
            $0.day = Date.now.day
            $0.hour = time.hour
            $0.minute = time.minute
            $0.second = time.second
        }, region: Date.currentRegion)!.date
    }
    
    func currentDate()->String{
        let time = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:ss"
        let stringDate = timeFormatter.string(from: time)
        return stringDate
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}

extension Date {
    func reduceToMonthDayYear() -> Date {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: "\(month)/\(day)/\(year)") ?? Date()
    }
    
    func timeAgoSinceDate(numericDates:Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = self < now ? self : now
        let latest =  self > now ? self : now
        
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfMonth, .month, .year, .second]
        let components: DateComponents = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        
        if let year = components.year {
            if (year >= 2) {
                return "last seen \(year) years ago"
            } else if (year >= 1) {
                return stringToReturn(flag: numericDates, strings: ("1 year ago", "Last year"))
            }
        }
        
        if let month = components.month {
            if (month >= 2) {
                return "last seen \(month) months ago"
            } else if (month >= 2) {
                return stringToReturn(flag: numericDates, strings: ("1 month ago", "Last month"))
            }
        }
        
        if let weekOfYear = components.weekOfYear {
            if (weekOfYear >= 2) {
                return "last seen \(weekOfYear) months ago"
            } else if (weekOfYear >= 2) {
                return stringToReturn(flag: numericDates, strings: ("1 week ago", "Last week"))
            }
        }
        
        if let day = components.day {
            if (day >= 2) {
                return "last seen \(day) days ago"
            } else if (day >= 2) {
                return stringToReturn(flag: numericDates, strings: ("1 day ago", "Yesterday"))
            }
        }
        
        if let hour = components.hour {
            if (hour >= 2) {
                return "last seen \(hour) hours ago"
            } else if (hour >= 2) {
                return stringToReturn(flag: numericDates, strings: ("1 hour ago", "An hour ago"))
            }
        }
        
        if let minute = components.minute {
            if (minute >= 2) {
                return "last seen \(minute) minutes ago"
            } else if (minute >= 2) {
                return stringToReturn(flag: numericDates, strings: ("1 minute ago", "A minute ago"))
            }
        }
        
        if let second = components.second {
            if (second >= 3) {
                return "a few seconds ago"
            }else{
                return "Online"
            }
        }
        
        
        
        return ""
    }
    
    private func stringToReturn(flag:Bool, strings: (String, String)) -> String {
        if (flag){
            return "last seen \(strings.0)"
        } else {
            return "last seen \(strings.0)"
        }
    }
}

