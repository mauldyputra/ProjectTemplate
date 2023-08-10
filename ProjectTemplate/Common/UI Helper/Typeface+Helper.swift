//
//  Typeface+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

extension UILabel {
    @IBInspectable var fontType: String? {
        set {
            updateFont(type: newValue, size: fontSize)
        }
        get {
            return font.getTypeface().type
        }
    }
    
    @IBInspectable var fontSize: CGFloat {
        set {
            updateFont(type: fontType, size: newValue)
        }
        get {
            return font.pointSize
        }
    }
    
    private func updateFont(type: String?, size: CGFloat) {
        let _type = type ?? Typeface.regular.type
        font = Typeface(rawValue: _type)?.size(size)
    }
}

extension UIButton {
    @IBInspectable var fontType: String {
        set {
            updateFont(type: newValue, size: fontSize)
        }
        get {
            return titleLabel?.font.getTypeface().type ?? Typeface.regular.type
        }
    }
    
    @IBInspectable var fontSize: CGFloat {
        set {
            updateFont(type: fontType, size: newValue)
        }
        get {
            return titleLabel?.font.pointSize ?? 13
        }
    }
    
    private func updateFont(type: String, size: CGFloat) {
        titleLabel?.font = Typeface(rawValue: type)?.size(size)
    }
}

extension UITextField {
    @IBInspectable var fontType: String {
        set {
            updateFont(type: newValue, size: fontSize)
        }
        get {
            return self.font?.getTypeface().type ?? Typeface.regular.type
        }
    }
    
    @IBInspectable var fontSize: CGFloat {
        set {
            updateFont(type: fontType, size: newValue)
        }
        get {
            return font?.pointSize ?? 13
        }
    }
    
    private func updateFont(type: String, size: CGFloat) {
        font = Typeface(rawValue: type)?.size(size)
    }
}

extension UITextView {
    @IBInspectable var fontType: String {
        set {
            updateFont(type: newValue, size: fontSize)
        }
        get {
            return self.font?.getTypeface().type ?? Typeface.regular.type
        }
    }
    
    @IBInspectable var fontSize: CGFloat {
        set {
            updateFont(type: fontType, size: newValue)
        }
        get {
            return font?.pointSize ?? 13
        }
    }
    
    private func updateFont(type: String, size: CGFloat) {
        font = Typeface(rawValue: type)?.size(size)
    }
}
