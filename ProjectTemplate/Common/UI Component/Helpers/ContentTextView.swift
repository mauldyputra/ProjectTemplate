//
//  ContentTextView.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import Atributika
import UIKit

class ContentTextView: UIView {
    var textView: UITextView = UITextView()
    
    var marginH: CGFloat = 0
    var marginV: CGFloat = 0
    
    var textDataDetectors: UIDataDetectorTypes = [.link, .phoneNumber] { didSet { updateTextView() }}
    var textAlignment: NSTextAlignment = .justified { didSet { updateTextView() }}
    var textColor: UIColor = Colors.UI.dark { didSet { updateTextView() }}
    var textFont: UIFont? { didSet { updateTextView() }}
    
    init(marginH: CGFloat = 0, marginV: CGFloat = 0) {
        super.init(frame: .zero)
        self.marginH = marginH
        self.marginV = marginV
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupViews()
        updateTextView()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(marginH)
            make.top.bottom.equalToSuperview().inset(marginV)
        }
    }
    
    private func updateTextView() {
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.dataDetectorTypes = textDataDetectors
        textView.textAlignment = textAlignment
        textView.textColor = textColor
        
        if let font = textFont {
            textView.font = font
        }
    }
    
    func configure(text: String, size: CGFloat = 13) {
        textView.text = text
        textView.fontSize = size
        
        layoutIfNeeded()
    }
    
    func configure(textOnly text: String) {
        textView.text = text
        
        layoutIfNeeded()
    }
    
    func configure(html: String, size: CGFloat = 13) {
        textView.setHtml(html, size: size)
        
        layoutIfNeeded()
    }
}
