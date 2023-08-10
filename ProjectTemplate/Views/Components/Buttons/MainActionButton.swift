//
//  MainActionButton.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

class MainActionButton: MainButton {
    
    @IBInspectable var title: String? = nil {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable var titleColor: UIColor? = nil {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable var titleAlignment: String? = nil {
        didSet {
            setNeedsLayout()
        }
    }

    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setTitleColor(titleColor ?? .white, for: .normal)
        setTitleColor((titleColor ?? .white).withAlphaComponent(0.7), for: .selected)
        setTitleColor((titleColor ?? .white).withAlphaComponent(0.5), for: .disabled)
        setTitle(title, for: .normal)
        
        titleLabel?.isHidden = title == nil
            
        let _type = titleAlignment ?? TextAlignment.center.rawValue
        if let alignment = TextAlignment(rawValue: _type) {
            titleLabel?.textAlignment = alignment.value
        }
    }
    
    func showLoading() {
        originalButtonText = self.title(for: .normal)
        setTitle(nil, for: .normal)

        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        isUserInteractionEnabled = false
        showSpinning()
    }

    func hideLoading() {
        isUserInteractionEnabled = true
        setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }

}
