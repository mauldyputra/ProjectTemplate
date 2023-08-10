//
//  UIButton+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import RxSwift
import RxCocoa

// MARK: - Handler
extension UIButton {
    /// Tap Handler for UIButton (Button as Rx Driver)
    @objc override func addTapHandler(_ handler: @escaping (() -> Void)) {
        self.rx
            .tap.asDriver().throttle(.seconds(1))
        .drive(onNext: { (btn) in
            if self.isUserInteractionEnabled {
                handler()
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - View Customizer
extension UIButton {
    func imageToRight() {
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
}

// MARK: - Addon - Notice
extension UIButton {
    func showNotice(_ show: Bool) {
        if show {
            guard subviews.first(where: { $0.tag == 5647 }) == nil else { return }
            // Add notice view
            let nView = UIView()
            nView.backgroundColor = .orange//Colors.UI.orangeSelected
            nView.tag = 5647
            nView.cornerRadius = 4
            
            addSubview(nView)
            nView.snp.remakeConstraints({
                $0.width.height.equalTo(8)
                $0.centerY.equalTo(self.snp.top)
                $0.centerX.equalTo(self.snp.trailing)
            })
        } else {
            // Remove notice view if any
            if let nView = subviews.first(where: { $0.tag == 5647 }) {
                nView.removeFromSuperview()
            }
        }
    }
}

