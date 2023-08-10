//
//  MainButton.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

class MainButton: UIButton {
    @IBInspectable var isRounded = false {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable var showShadow: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable var disabledBackgroundColor: UIColor?
    @IBInspectable var disabledBorderColor: UIColor?
    
    @IBInspectable var normalBackgroundColor: UIColor?
    @IBInspectable var normalBorderColor: UIColor?
    
    @IBInspectable var selectedBackgroundColor: UIColor?
    @IBInspectable var selectedBorderColor: UIColor?
    
    override var isEnabled: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    var shadowView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateBackgroundColor()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        if normalBackgroundColor == nil {
            normalBackgroundColor = backgroundColor
        }
        
        if normalBorderColor == nil {
            normalBorderColor = .clear
        }
        
        if isEnabled {
            backgroundColor = isSelected ? selectedBackgroundColor : normalBackgroundColor
            borderColor = isSelected ? selectedBorderColor : normalBorderColor
        } else {
            backgroundColor = disabledBackgroundColor
            borderColor = disabledBorderColor
        }
    }
    
    private func updateShadowView() {
        if shadowView.superview == nil {
            shadowView = UIView(frame: self.frame)
            shadowView.clipsToBounds = false
            shadowView.layer.masksToBounds = false
            shadowView.layer.shouldRasterize = true
            shadowView.layer.rasterizationScale = UIScreen.main.scale
            
            if let superview = superview {
                superview.insertSubview(shadowView, belowSubview: self)
                shadowView.snp.makeConstraints { (make) in
                    make.center.width.height.equalTo(self)
                }
            }
        }
        
        shadowView.layer.cornerRadius = cornerRadius
        shadowView.layer.shadowOffset = .init(width: 1, height: 1)
        shadowView.layer.shadowRadius = 2
        shadowView.layer.shadowOpacity = 0.2
        
        shadowView.isHidden = !showShadow
        
        shadowView.backgroundColor = backgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isRounded {
            layer.cornerRadius = bounds.height/2
        } else {
            layer.cornerRadius = cornerRadius
        }

        updateShadowView()
    }
    
    func animateHidden(_ hidden: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = hidden ? 0 : 1
            self.shadowView.alpha = hidden ? 0 : 1
        }) { (bool) in
            self.isHidden = hidden
            self.shadowView.isHidden = hidden
        }
    }
}
