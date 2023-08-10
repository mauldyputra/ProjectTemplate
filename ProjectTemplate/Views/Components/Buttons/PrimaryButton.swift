//
//  PrimaryButton.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

class PrimaryButton: UIView {
    
    @IBInspectable var title: String? = "" { didSet { setNeedsLayout() }}
    @IBInspectable var showArrow: Bool = true { didSet { setNeedsLayout() }}
    @IBInspectable var leftText: String? = nil { didSet { updateView();setNeedsLayout() }}
    @IBInspectable var isInverted: Bool = false { didSet { updateView();setNeedsLayout() }}
    
    var custom: Bool = false { didSet { updateView();setNeedsLayout()}}
    
    var isEnabled: Bool = true { didSet { updateView() }}
    
    private let stackView: UIStackView = UIStackView()
    private let button: MainActionButton = MainActionButton()
    
    lazy private var leftLabel: InsetLabel = {
        let l = InsetLabel()
        l.marginH = 24
        l.marginV = 12
        l.font = Typeface(rawValue: "medium")!.size(13)
        l.textColor = .white//Colors.UI.offWhite
        l.backgroundColor = .darkText//Colors.UI.darkHighlight
        return l
    }()
    lazy private var arrowView: UIView = {
        let s = UIView()
        let a = UIView()
        a.backgroundColor = .white//Colors.UI.offWhite
        a.cornerRadius = 10
        s.snp.remakeConstraints({ $0.width.equalTo(self.frame.height) })
        s.addSubview(a)
        a.snp.remakeConstraints { (make) in
            make.height.width.equalToSuperview().inset(8)
            make.center.equalToSuperview()
        }
        let i = UIImageView()
        i.image = UIImage(named: "ic-arrow-right-orange-full")
        a.addSubview(i)
        i.snp.remakeConstraints({ $0.top.bottom.leading.trailing.equalToSuperview().inset(8) })
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title = ""
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !custom {
            button.titleColor = isInverted ? .white : .white//Colors.UI.offWhite : Colors.UI.offWhite
            backgroundColor = isInverted ? .darkGray : .orange//Colors.UI.dark45 : Colors.UI.orangeSelected
            borderWidth = isInverted ? 0 : 1
            borderColor = isInverted ? UIColor.clear : .orange//Colors.UI.orangeSelected
        }
        
        cornerRadius = 10
        button.title = title
        leftLabel.text = leftText
        
        button.fontType = "bold"
        button.fontSize = 13
    }
    
    func updateView() {
        stackView.removeArrangedSubviews()
        alpha = isEnabled ? 1 : 0.65
        isUserInteractionEnabled = isEnabled
        
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.snp.remakeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        if let _ = leftText {
            leftLabel.setContentHuggingPriority(.required, for: .horizontal)
            stackView.addArrangedSubview(leftLabel)
        } else {
            if showArrow {
                let firstSpacer = UIView()
                firstSpacer.backgroundColor = .clear
                firstSpacer.snp.remakeConstraints({ $0.width.equalTo(48) })
                stackView.addArrangedSubview(firstSpacer)
            }
        }
        
        if let _ = title {
            button.isUserInteractionEnabled = false
            button.isEnabled = isEnabled
            stackView.addArrangedSubview(button)
        }
        
        if showArrow {
            arrowView.alpha = isEnabled ? 1 : 0.65
            stackView.addArrangedSubview(arrowView)
        } else {
            if let _ = leftText {
                let secondSpacer = UIView()
                secondSpacer.backgroundColor = .clear
                secondSpacer.snp.remakeConstraints({ $0.width.equalTo(48) })
                stackView.addArrangedSubview(secondSpacer)
            }
        }
    }
    
    func customColor(title: UIColor = .white/*Colors.UI.offWhite*/, background: UIColor = .orange/*Colors.UI.orangeSelected*/ , borderWidth: CGFloat = 0, borderColor: UIColor = .clear){
        self.custom = true
        self.button.titleColor = title
        self.backgroundColor = background
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
    
    func setAction(_ handler: @escaping (() -> Void)) {
        addTapHandler(handler)
    }
    
    func showLoading() {
        button.showLoading()
    }
    
    func hideLoading() {
        button.hideLoading()
    }
    
    func setEnableButton(bool: Bool) {
        button.isUserInteractionEnabled = bool
    }

}
