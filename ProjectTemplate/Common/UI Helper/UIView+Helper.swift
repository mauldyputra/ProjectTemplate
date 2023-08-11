//
//  UIView+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import RxSwift
import RxGesture
import SkeletonView
import SnapKit
import UIKit

var isShadowValue: Bool = false

extension UIView {
    struct properties {
        static var disposeBag = DisposeBag()
    }
    
    var disposeBag: DisposeBag {
        return properties.disposeBag
    }

    /// Tap Handler for UIView
    @objc func addTapHandler(_ handler: @escaping (() -> Void)) {
        if let recognizers = gestureRecognizers {
            for gr in recognizers {
                if gr is UITapGestureRecognizer {
                    removeGestureRecognizer(gr)
                }
            }
        }
        self.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { (_) in
                if self.isUserInteractionEnabled {
                    handler()
                }
            }).disposed(by: disposeBag)
    }
}

extension UIView {
    convenience init(withHeight height: CGFloat) {
        self.init()
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    convenience init(withWidth width: CGFloat) {
        self.init()
        
        self.snp.makeConstraints { (make) in
            make.width.equalTo(width)
        }
    }
    
    convenience init(withHeight height: CGFloat, withWidth width: CGFloat) {
        self.init()
        
        self.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    func setViewHeight(_ height: CGFloat) {
        self.snp.makeConstraints({ $0.height.equalTo(height) })
    }
    
    func getHeightMinus(views: [UIView], adding: CGFloat = 0) -> CGFloat {
        let minus = views.map({ $0.frame.height }).reduce(0, {(x, y) in
            x + y
        })
        return self.frame.height - minus - adding
    }
    
    func getHeightMinus(_ min: CGFloat) -> CGFloat {
        return self.frame.height - min
    }
    
    convenience init(withHeight height: CGFloat, bgColor: UIColor) {
        self.init()
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
        self.backgroundColor = bgColor
    }
}

extension UIView {
    /* BORDER */
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    /* BORDER RADIUS */
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            
            if layer.masksToBounds {
                layer.shouldRasterize = true
                layer.rasterizationScale = UIScreen.main.scale
            } else {
                layer.shouldRasterize = false
            }
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var makeRounded: Bool {
        set {
            layer.cornerRadius = newValue ? self.frame.height / 2 : 0
            layer.masksToBounds = newValue
            
            if layer.masksToBounds {
                layer.shouldRasterize = true
                layer.rasterizationScale = UIScreen.main.scale
            } else {
                layer.shouldRasterize = false
            }
        }
        get {
            return false
        }
    }
    
    /* SEPARATOR */
    @IBInspectable var showSeparator: Bool {
        set {
            if newValue {
                let separator = UIView()
                separator.tag = 781
                separator.backgroundColor = Colors.UI.lightGrey
                self.insertSubview(separator, at: subviews.count)
                separator.snp.makeConstraints { (make) in
                    make.left.bottom.right.equalToSuperview()
                    make.height.equalTo(1)
                }
            } else {
                self.subviews.forEach { (v) in
                    if v.tag == 781 { v.removeFromSuperview() }
                }
            }
        }
        get {
            return false
        }
    }
}

extension UIView {
    static func nib<T: UIView>(withType type: T.Type, name: String? = nil) -> T {
        let _name = name ?? String(describing: type)
        return Bundle.main.loadNibNamed(_name, owner: self, options: nil)?.first as! T
    }
}

extension UIView {
    var isShadowActive: Bool {
        set {
            isShadowValue = newValue
        }
        get {
            return isShadowValue
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addShadow(cornerRadius: CGFloat? = nil, offset: CGSize? = nil, radius: CGFloat? = nil, opacity: CGFloat? = nil) {
        subviews.forEach { (v) in
            if v is ShadowView {
                v.removeFromSuperview()
            }
        }
        
        let shadowView = ShadowView(frame: self.frame)
        
        if let cr = cornerRadius { shadowView.cornerRadius = cr }
        if let o = offset { shadowView.shadowOffset = o }
        if let r = radius { shadowView.shadowRadius = r }
        if let so = opacity { shadowView.shadowOpacity = Float(so) }
        
        if let superview = superview {
            superview.insertSubview(shadowView, belowSubview: self)
            shadowView.snp.makeConstraints { (make) in
                make.center.width.height.equalTo(self)
            }
        }
        
        shadowView.backgroundColor = backgroundColor
        isShadowActive = true
    }
}

extension UIView {
    func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func getSubviewsOfView(view: UIView) -> [UIView] {
        var subviewArray = [UIView]()
        if view.subviews.count == 0 {
            return subviewArray
        }
        for subview in view.subviews {
            subviewArray += self.getSubviewsOfView(view: subview)
            subviewArray.append(subview)
        }
        return subviewArray
    }
    
    @objc func setDisabled(stillActionable actionable: Bool = false, alpha: CGFloat = 0.65) {
        isUserInteractionEnabled = actionable
        self.alpha = alpha
    }
    
    @objc func setEnabled() {
        isUserInteractionEnabled = true
        alpha = 1
    }
}

extension UIButton {
    override func setDisabled(stillActionable actionable: Bool = false, alpha: CGFloat = 0.65) {
        isUserInteractionEnabled = actionable
        self.alpha = alpha
    }
    
    override func setEnabled() {
        isUserInteractionEnabled = true
        alpha = 1
    }
    
    func setInverted(isInverted: Bool = false) {
        setTitleColor(isInverted ? Colors.UI.offWhite : Colors.UI.offWhite, for: .normal)
        self.backgroundColor = isInverted ? Colors.UI.dark45 : Colors.UI.orangeSelected
        self.borderWidth = isInverted ? 0 : 1
        self.borderColor = isInverted ? UIColor.clear : Colors.UI.orangeSelected
        self.layoutIfNeeded()
    }
}

extension UIStackView {
    func addArrangedSubviewAtLast(_ view: UIView) {
        insertArrangedSubview(view, at: arrangedSubviews.count)
    }
    
    func removeArrangedSubviews() {
        arrangedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIView {
    func layerGradient(topColor: UIColor, bottomColor: UIColor) {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint(x: 0.0, y: 0.0)

        layer.colors = [topColor.cgColor, bottomColor.cgColor]
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func addDashedBorder(wihtColor: UIColor?) {
        let color = wihtColor?.cgColor ?? Colors.UI.lightGrey.cgColor
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.name = "dashedBorder"
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
    func removeDashedBorder(){
        if let dashedLayer = self.layer.sublayers?.filter({ $0.name == "dashedBorder"}).first {
            dashedLayer.removeFromSuperlayer()
        }
    }
}

