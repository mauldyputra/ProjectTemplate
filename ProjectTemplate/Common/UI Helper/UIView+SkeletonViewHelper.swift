//
//  UIView+SkeletonViewHelper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import SkeletonView
import UIKit

protocol Skeletonable {
    func showLoadingSkeleton(_ bool: Bool)
}

extension UIView {
    func hideSkeletonAnimated() {
        self.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.3))
    }
    
    func activateSkeletonWithinView() {
        let subviews = self.getSubviewsOfView(view: self)
        
        subviews.forEach { (v) in
            if v.isSkeletonable {
                v.showAnimatedSkeleton()
            }
        }
    }
    
    func deactivateSkeletonWithinView() {
        let subviews = self.getSubviewsOfView(view: self)
        
        subviews.forEach { (v) in
            v.hideSkeletonAnimated()
        }
    }
}

extension UILabel {
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.lastLineFillPercent = 50
        self.linesCornerRadius = 5
    }
}

