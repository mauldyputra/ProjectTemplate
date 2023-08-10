//
//  UIStackView+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

extension UIStackView {
    func addSeparator(withColor color: UIColor? = .gray/*Colors.UI.lightGrey*/, at: Int?) {
        let v = UIView()
        v.backgroundColor = color
        v.snp.makeConstraints { (make) in
            make.height.equalTo(1)
        }
        if let at = at {
            self.insertArrangedSubview(v, at: at)
        } else {
            self.addArrangedSubview(v)
        }
    }
    
    func addSpacer(height: CGFloat? = nil, at: Int? = nil, bg: UIColor = .clear, tag: Int? = nil) {
        let v = UIView()
        v.backgroundColor = bg
        if let height = height {
            v.snp.makeConstraints({ $0.height.equalTo(height) })
        }
        if let at = at {
            insertArrangedSubview(v, at: at)
        } else {
            addArrangedSubview(v)
        }
        if let tag = tag {
            v.tag = tag
        }
    }
}
