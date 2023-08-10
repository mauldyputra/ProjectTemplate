//
//  UILabel+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

extension UILabel {
    func setHtml(_ html: String, size: CGFloat = 13) {
        let cleanedHtml = html.replacingOccurrences(of: "<p>", with: " ").replacingOccurrences(of: "</p>", with: " ")
        attributedText = try? NSAttributedString(htmlString: cleanedHtml,
                                                 font: Typeface(rawValue: "regular")?.size(size),
                                                 bold: Typeface(rawValue: "semibold")?.size(size),
                                                 italic: Typeface(rawValue: "italic")?.size(size),
                                                 useDocumentFontSize: false)
    }
    
    var isTruncated: Bool {

        guard let labelText = text else {
            return false
        }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size

        return labelTextSize.height > bounds.size.height
    }
}
