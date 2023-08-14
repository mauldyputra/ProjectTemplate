//
//  BaseScrollController.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 11/08/23.
//

import UIKit

class BaseScrollController: BaseController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var isKeyboardVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: scrollView.contentSize.height)
    }
}
