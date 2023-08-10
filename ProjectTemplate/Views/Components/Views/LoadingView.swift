//
//  LoadingView.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit
import ASSpinnerView

class LoadingView: UIView {
    @IBOutlet var contentView: UIView?
    @IBOutlet private var spinner: ASSpinnerView?
    @IBOutlet private var label: UILabel?
    
    var title: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        spinner?.spinnerDuration = 0.5
        spinner?.spinnerLineWidth = 3
        spinner?.spinnerStrokeColor = UIColor.darkGray.cgColor//Colors.UI.dark.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let title = title { label?.text = title }
    }
}
