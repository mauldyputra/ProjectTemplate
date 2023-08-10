//
//  EmptyView.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

class EmptyView: UIView {
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var subtitleLabel: UILabel?
    @IBOutlet private var imageView: UIImageView?
    @IBOutlet private var spacerView: UIView?
    @IBOutlet private var actionButton: MainActionButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(title: String?, subtitle: String?, image: UIImage? = nil, actionTitle: String?, action: (() -> Void)?) {
        titleLabel?.isHidden = title == nil
        titleLabel?.text = title
        subtitleLabel?.isHidden = subtitle == nil
        subtitleLabel?.text = subtitle
        spacerView?.isHidden = actionTitle == nil
        imageView?.isHidden = image == nil
        imageView?.image = image
        actionButton?.isHidden = actionTitle == nil
        actionButton?.title = actionTitle
        if let t = title {
            let line = t.count / 40
            if t.count % 40 > 0 { titleLabel?.numberOfLines = line + 1 }
            else { titleLabel?.numberOfLines = line }
        }
        if let action = action { actionButton?.addTapHandler(action) }
    }
}
