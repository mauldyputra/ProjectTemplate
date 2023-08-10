//
//  UITableView+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

extension UITableView {
    override open var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.separatorStyle = .none
        self.tableFooterView = UIView()
    }
    
    func setDelegate(_ delegate: UITableViewDelegate&UITableViewDataSource, setRowHeight height: CGFloat? = nil) {
        self.delegate = delegate
        self.dataSource = delegate
        
        self.estimatedRowHeight = 96
        self.rowHeight = height == nil ? UITableView.automaticDimension : height!
    }
}

extension UITableView {
    func reloadAllSections() {
        let sections = self.numberOfSections
        if sections > 0 {
            self.reloadSections(IndexSet(integersIn: 0..<sections), with: .automatic)
        } else {
            self.reloadData()
        }
    }
    
    func reloadMaintainOffset() {
        let offset = contentOffset
        self.reloadData()
        self.setContentOffset(offset, animated: false)
    }
}
