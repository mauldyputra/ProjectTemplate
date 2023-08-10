//
//  UITextField+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UITextField {
    func centeredPlaceholder(str: String) {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: str, attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        self.attributedPlaceholder = attributedPlaceholder
    }
}

extension UITextView {
    func setHtml(_ html: String, size: CGFloat = 13) {
        attributedText = try? NSAttributedString(htmlString: html,
                                                 font: Typeface(rawValue: "regular")?.size(size),
                                                 bold: Typeface(rawValue: "semibold")?.size(size),
                                                 italic: Typeface(rawValue: "italic")?.size(size),
                                                 useDocumentFontSize: false)
    }
}

