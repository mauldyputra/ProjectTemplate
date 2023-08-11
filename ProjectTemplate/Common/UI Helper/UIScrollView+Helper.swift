//
//  UIScrollView+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

extension UIScrollView {
    var minContentOffset: CGPoint {
      return CGPoint(
        x: -contentInset.left,
        y: -contentInset.top)
    }

    var maxContentOffset: CGPoint {
      return CGPoint(
        x: contentSize.width - bounds.width + contentInset.right,
        y: contentSize.height - bounds.height + contentInset.bottom)
    }

    func scrollToMinContentOffset(animated: Bool) {
      setContentOffset(minContentOffset, animated: animated)
    }

    func scrollToMaxContentOffset(animated: Bool) {
      setContentOffset(maxContentOffset, animated: animated)
    }
    
    func scrollToBottom(animated: Bool = true, delay: Double = 0.1) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else {
                return
            }
            let contentSize = self.contentSize
            let offsetY = max(contentSize.height - self.bounds.height, 0)
            let newOffset = CGPoint(x: self.contentOffset.x, y: offsetY)
            self.setContentOffset(newOffset, animated: animated)
        }
    }
}

extension UICollectionView {
    func rectCoordinateFor(indexPath: IndexPath) -> CGRect {
        let layoutAttr = self.layoutAttributesForItem(at: indexPath)
        let rect = layoutAttr?.frame ?? CGRect.null
        
        return self.convert(rect, to: self)
    }
}

extension UIScrollView {
    func addRefreshControl(in vc: UIViewController, title: String = "Loading...", tintColor: UIColor = Colors.UI.grey) {
        let refreshControl: UIRefreshControl = UIRefreshControl(frame: .zero)
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.tintColor = tintColor
        refreshControl.addTarget(vc, action: #selector(refreshControlValueChanged(_:)), for: .valueChanged)
        
        self.refreshControl = refreshControl
    }
    
    @objc func refreshControlValueChanged(_ sender: UIRefreshControl) {}
}

extension UICollectionView {
    func register(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(cellClass, forCellWithReuseIdentifier: className)
    }
    
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T
    }
    
    func registerHeader(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
    }
    
    func registerHeaderNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(UINib(nibName: className, bundle: nil),
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: className)
    }
    
    func dequeueHeader<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
        let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                    withReuseIdentifier: String(describing: cellClass),
                                                    for: indexPath) as? T
        return view
    }
    
    func registerFooter(_ footerClass: AnyClass) {
        let className = String(describing: footerClass)
        self.register(footerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
    }
    
    func dequeueFooter<T>(_ footerClass: T.Type, for indexPath: IndexPath) -> T? {
        let className = String(describing: footerClass)
        let footer = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className, for: indexPath)
        return footer as? T
    }
}

extension UITableView {
    func register(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: className)
    }
    
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
    }
    
    func dequeueCell<T>(with cellClass: T.Type, indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as? T
    }
    
    func registerHeaderFooter(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(cellClass, forHeaderFooterViewReuseIdentifier: className)
    }
    
    func registerHeaderFooterView(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forHeaderFooterViewReuseIdentifier: className)
    }
    
    func dequeueHeaderFooterView<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: cellClass)) as? T
    }
}

