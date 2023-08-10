//
//  UIView+AnimationHelper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

extension UIView {
    static private let kRotationKey = "rotationanimationkey"
    
    func startRotating(repeating: Float? = nil) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = repeating == nil ? .infinity : repeating!
        self.layer.add(rotation, forKey: UIView.kRotationKey)
    }
    
    func stopRotating() {
        self.layer.removeAnimation(forKey: UIView.kRotationKey)
    }
    
    func flash(numberOfFlashes: Float) {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = numberOfFlashes
        layer.add(flash, forKey: nil)
    }
}

