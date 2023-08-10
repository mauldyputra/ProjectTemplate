//
//  NumberUtils.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

extension Int {
    var asString: String {
        return "\(self)"
    }
    
    var asPoints: String {
        return "\(self.formatted) Points"
    }
    
    var asCurrency: String {
        return "IDR \(self.formatted)"
    }
    
    var asIDCurrency: String {
        return "Rp. \(self.formatted)"
    }
    
    var toFloat: Float {
        return Float(self)
    }
    
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current

        let formattedString = formatter.string(for: self)
        return formattedString ?? self.asString
    }
    
    var toCountDown: String {
        let minutes = self / 60
        let seconds = self % 60
        
        if minutes < 10 && seconds < 10 {
            return "0\(minutes):0\(seconds)"
        } else if minutes < 10 && seconds >= 10 {
            return "0\(minutes):\(seconds)"
        } else if minutes >= 10 && seconds < 10 {
            return "\(minutes):0\(seconds)"
        } else {
            return "\(minutes):\(seconds)"
        }
    }
}

extension CGFloat {
    var deg2rad: CGFloat {
        return self * .pi / 180
    }
}

extension Float {
    var asString: String {
        return "\(self)"
    }
    
    // In meters
    var asDistanceString: String {
        if self < 1000 {
            return "\(self.trimOneDecimal) m"
        } else {
            return "\((self / 1000).trimOneDecimal) km"
        }
    }
    
    var asPoints: String {
        return "\(self.clean) Points"
    }
    
    var asCurrency: String {
        return "IDR \(self.clean)"
    }
    
    var asIDCurrency: String {
        return "Rp. \(self.formatted)"
    }
    
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : self.trimOneDecimal
    }
    
    var squared: Float {
        return pow(self, 2)
    }
    
    var trimDecimals: String {
        return String(format: "%.0f", self)
    }
    
    var trimOneDecimal: String {
        return String(format: "%.1f", self)
    }
    
    var trimTwoDecimals: String {
        return String(format: "%.2f", self)
    }
    
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current

        let formattedString = formatter.string(for: self)
        return formattedString ?? self.asString
    }
}

extension Double {
    var asString: String {
        return "\(self)"
    }
    
    // In meters
    var asDistanceString: String {
        if self < 1000 {
            return "\(self.trimOneDecimal) m"
        } else {
            return "\((self / 1000).trimOneDecimal) km"
        }
    }
    
    var asPoints: String {
        return "\(self.clean) Points"
    }
    
    var asCurrency: String {
        return "IDR \(self.clean)"
    }
    
    var asIDCurrency: String {
        return "Rp. \(self.formatted)"
    }
    
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    var squared: Double {
        return pow(self, 2)
    }
    
    var trimOneDecimal: String {
        return String(format: "%.1f", self)
    }
    
    var trimTwoDecimals: String {
        return String(format: "%.2f", self)
    }
    
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current

        let formattedString = formatter.string(for: self)
        return formattedString ?? self.asString
    }
}

