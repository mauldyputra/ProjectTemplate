//
//  Menu.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 11/08/23.
//

import UIKit

enum Menu: Int {
    case Home = -1
    case Account = 0
    case Appointment = 1
    case Coupon = 2
    
    var icon: UIImage? {
        switch self {
        case .Account: return UIImage(named: "ic-menu-account")
        case .Appointment: return UIImage(named: "ic-menu-appointment")
        case .Coupon: return UIImage(named: "ic-menu-coupon")
        default: return nil
        }
    }
    
    var name: String {
        switch self {
        case .Account: return "Account"
        case .Appointment: return "Appointment"
        case .Coupon: return "Coupon"
        default: return ""
        }
    }
}
