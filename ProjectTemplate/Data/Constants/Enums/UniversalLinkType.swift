//
//  UniversalLinkType.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 14/08/23.
//

import Foundation

enum UniversalLinkType: String {
    case MyAppointmentDetail = "/dashboard/profile/my-appointment"
}

extension URL {
    func getUniversalLink() -> UniversalLinkType? {
        if self.absoluteString.contains(UniversalLinkType.MyAppointmentDetail.rawValue) {
            return .MyAppointmentDetail
        } else {
            return nil
        }
    }
}
