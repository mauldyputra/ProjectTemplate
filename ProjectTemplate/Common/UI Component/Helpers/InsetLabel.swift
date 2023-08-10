//
//  InsetLabel.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

class InsetLabel: UILabel {
    @IBInspectable var marginH: CGFloat = 0
    @IBInspectable var marginV: CGFloat = 0
    @IBInspectable var customBottom: Bool = false
    @IBInspectable var marginBottom: CGFloat = 0

    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    convenience init(marginH: CGFloat, marginV: CGFloat, text: String) {
        self.init()
        self.marginH = marginH
        self.marginV = marginV
        self.text = text
        
        numberOfLines = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if makeRounded {
            cornerRadius = bounds.height / 2
        }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        if text == nil {
            return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        }
        
        if textInsets == UIEdgeInsets.zero {
            textInsets = UIEdgeInsets(top: marginV, left: marginH, bottom: marginV, right: marginH)
        }
        
        if customBottom {
            textInsets = UIEdgeInsets(top: marginV, left: marginH, bottom: marginBottom, right: marginH)
        }
        
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        if text == nil {
            return super.drawText(in: rect)
        }
        
        if textInsets == UIEdgeInsets.zero {
            textInsets = UIEdgeInsets(top: marginV, left: marginH, bottom: marginV, right: marginH)
        }
        
        if customBottom {
            textInsets = UIEdgeInsets(top: marginV, left: marginH, bottom: marginBottom, right: marginH)
        }
        
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    func configure(html: String, size: CGFloat = 13) {
        setHtml(html, size: size)
    }
}
