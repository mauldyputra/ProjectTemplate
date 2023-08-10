//
//  SnackbarView.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

class SnackbarView: UIView {
    @IBOutlet private var contentView: UIView?
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var subtitleLabel: UILabel?
    @IBOutlet weak var closeButton: UIButton?
    
    func configure(title: String, subtitle: String, color: UIColor) {
        titleLabel?.text = title
        subtitleLabel?.text = subtitle
        contentView?.backgroundColor = color
        setNeedsLayout()
        layoutIfNeeded()
    }
}
