//
//  ShadowView.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

class ShadowView: UIView {
    @IBInspectable var shadowOpacity: Float = 0.15
    @IBInspectable var shadowRadius: CGFloat = 5
    @IBInspectable var shadowCornerRadius: CGFloat = 5
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 2, height: 2)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.cornerRadius = shadowCornerRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = shadowColor.cgColor
    }
}
