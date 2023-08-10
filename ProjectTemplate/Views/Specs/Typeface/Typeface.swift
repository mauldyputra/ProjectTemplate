//
//  Typeface.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

enum Typeface: String {
    case black = "black"
    case bold = "bold"
    case extraBold = "extra-bold"
    case extraLight = "extra-light"
    case italic = "italic"
    case light = "light"
    case medium = "medium"
    case regular = "regular"
    case semibold = "semibold"
    case thin = "thin"
    
    var type: String {
        return rawValue
    }
    
    var name: String {
        switch self {
        case .black: return "Montserrat-Black"
        case .bold: return "Montserrat-Bold"
        case .extraBold: return "Montserrat-ExtraBold"
        case .extraLight: return "Montserrat-ExtraLight"
        case .italic: return "Montserrat-Italic"
        case .light: return "Montserrat-Light"
        case .medium: return "Montserrat-Medium"
        case .regular: return "Montserrat-Regular"
        case .semibold: return "Montserrat-SemiBold"
        case .thin: return "Montserrat-Thin"
        }
    }
    
    var faceName: String {
        switch self {
        case .black: return "Black"
        case .bold: return "Bold"
        case .extraBold: return "ExtraBold"
        case .extraLight: return "ExtraLight"
        case .italic: return "Italic"
        case .light: return "Light"
        case .medium: return "Medium"
        case .regular: return "Regular"
        case .semibold: return "SemiBold"
        case .thin: return "Thin"
        }
    }
    
    func size(_ size: CGFloat = 13) -> UIFont {
        return UIFont(name: self.name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension UIFont {
    func getTypeface() -> Typeface {
        switch fontName {
        case Typeface.black.name:
            return .black
        case Typeface.bold.name:
            return .bold
        case Typeface.extraBold.name:
            return .extraBold
        case Typeface.light.name:
            return .light
        case Typeface.extraLight.name:
            return .extraLight
        case Typeface.medium.name:
            return .medium
        case Typeface.semibold.name:
            return .semibold
        case Typeface.thin.name:
            return .thin
        default:
            return .regular
        }
    }
}
