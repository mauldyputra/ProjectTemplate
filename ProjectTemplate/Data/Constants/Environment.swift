//
//  Environment.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation

let environment: Environment = .UAT

enum Environment {
    case Production
    case Development
    case UAT
    
    var keyEncryption: String {
        switch self {
        case .Production: return "36FFEFC1B8D77C9265F355487E934-private.key"
        case .Development: return "private.key"
        case .UAT: return "private.key"
        }
    }
}
