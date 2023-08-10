//
//  BaseView.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class BaseCustomView: UIView {
    @IBOutlet var view: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }

    func commonInit() {
        backgroundColor = .clear
        
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        
        addContent(view)
    }
    
    func addContent(_ content: UIView?) {
        guard let content = content else {
            return
        }
        addSubview(content)
        content.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
        resignFirstResponder()
    }
}

class BaseCustomControl: BaseControl {
    @IBOutlet var view: UIView?
    
    override func commonInit() {
        backgroundColor = .clear
        
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        
        addContent(view)
    }
    
    func addContent(_ content: UIView?) {
        guard let content = content else {
            return
        }
        addSubview(content)
        content.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
    }
}

class BaseControl: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {}
}

enum TextAlignment: String {
    case left = "left"
    case center = "center"
    case right = "right"

    var type: String {
        return rawValue
    }
    
    var value: NSTextAlignment {
        switch self {
        case .left: return .left
        case .center: return .center
        case .right: return .right
        }
    }
}
