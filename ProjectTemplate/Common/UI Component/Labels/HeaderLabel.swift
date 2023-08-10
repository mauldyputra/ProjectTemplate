//
//  HeaderLabel.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

class HeaderLabel: InsetLabel {
    
    override func layoutSubviews() {
        marginH = 16
        marginV = 8
        marginBottom = 0
        customBottom = true
        
        self.font = Typeface.bold.size(20)
        self.textColor = .darkText//Colors.UI.dark
        self.numberOfLines = 0
        
        super.layoutSubviews()
    }
}
