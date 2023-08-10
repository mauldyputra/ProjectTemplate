//
//  UIView+StateHelper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

extension UIView {
    var isHiddenInStackView: Bool {
        get {
            return isHidden
        }
        set {
            if isHidden != newValue {
                isHidden = newValue
            }
        }
    }
    
    func setIsLoading(_ loading: Bool) {
        if loading { activateSkeletonWithinView() }
        else { deactivateSkeletonWithinView() }
    }
    
    func setIsEmpty(_ empty: Bool, title: String?, subtitle: String?, equalToWidth: Bool? = false, image: UIImage? = nil) {
        let ev = UIView.nib(withType: EmptyView.self)
        ev.configure(title: title, subtitle: subtitle, image: image, actionTitle: nil, action: nil)
        
        if empty {
            ev.tag = 5991
            self.addSubview(ev)
            ev.snp.makeConstraints({ (make) in
                make.leading.top.bottom.equalTo(self)
                make.trailing.equalTo(-10)
                if equalToWidth == true {
                    make.width.equalTo(self)
                }
            })
        } else {
            for s in subviews {
                if s.tag == 5991 {
                    s.removeFromSuperview()
                }
            }
        }
    }
    
    func setIsError(_ error: Bool, reloadAction action: (() -> Void)? = nil) {
        let reloadView = ReloadView()
        reloadView.configure(reloadAction: action)
        
        if error {
            reloadView.tag = 4999
            self.addSubview(reloadView)
            reloadView.snp.makeConstraints({ (make) in
                make.leading.trailing.top.bottom.equalTo(self)
            })
        } else {
            for s in subviews {
                if s.tag == 4999 {
                    s.removeFromSuperview()
                }
            }
        }
    }
}

