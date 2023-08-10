//
//  ReloadView.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

class ReloadView: UIView {
    private let stackView = UIStackView()
    private let label = UILabel()
    private let icon = UIImageView()
    
    private var isLoading: Bool = false {
        didSet {
            updateViews()
        }
    }
    private var message: String = "Reload"
    private var loadingAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit() {
        backgroundColor = .white
        label.text = message
        addTapHandler {
            self.setLoading(false)
            self.loadingAction?()
            self.setLoading(true)
        }
        
        stackView.spacing = 8
        
        label.font = Typeface(rawValue: "light")!.size(13)
        label.textColor = .darkGray//Colors.UI.dark45
        
        icon.image = UIImage(named: "ic-reload")
        icon.snp.makeConstraints { (make) in
            make.height.width.equalTo(16)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(icon)
    }
    
    func configure(reloadAction action: (() -> Void)?) {
        self.loadingAction = action
    }
    
    func setLoading(_ bool: Bool) {
        isLoading = bool
    }
    
    private func updateViews() {
        if isLoading { icon.startRotating() }
        else { icon.stopRotating() }
    }
}
