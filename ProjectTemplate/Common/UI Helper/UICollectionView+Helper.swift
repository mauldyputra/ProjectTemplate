//
//  UICollectionView+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

extension UICollectionView {
    override open var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

extension UICollectionView {
    func selectItemCentered(_ indexPath: IndexPath) {
        if #available(iOS 14, *) {
            guard let cell = layoutAttributesForItem(at: indexPath) else { return }
            var point = convert(cell.frame, to: self).origin
            
            let scrollDirection = (collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection
            let numOfCells = numberOfItems(inSection: indexPath.section)
            switch indexPath.item {
            case 0:
                // Scroll to first item
                point = .zero
            case numOfCells - 1:
                // Scroll to last item
                let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
                let sectionEndMargin = scrollDirection == .horizontal ? (flowLayout?.sectionInset.right ?? 0) : (flowLayout?.sectionInset.bottom ?? 0)
                
                if scrollDirection == .horizontal {
                    let remainingWidth = (frame.width - cell.frame.width - sectionEndMargin)
                    point.x -= remainingWidth
                } else {
                    let remainingHeight = (frame.height - cell.frame.height - sectionEndMargin)
                    point.y -= remainingHeight
                }
                
            default:
                // Default
                if scrollDirection == .horizontal {
                    let remainingWidth = (frame.width - cell.frame.width) / 2
                    point.x -= remainingWidth
                } else {
                    let remainingHeight = (frame.height - cell.frame.height)
                    point.y -= remainingHeight
                }
            }
            
            setContentOffset(point, animated: true)
        } else {
            selectItem(at: indexPath,
                            animated: false,
                            scrollPosition: .init(rawValue: 0))
            scrollToItem(at: indexPath,
                         at: .centeredHorizontally,
                         animated: true)
        }
    }
    
    func getNearestIndexPath(in section: Int) -> IndexPath {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.item
            }
        }
        
        return IndexPath(item: closestCellIndex, section: section)
    }
}

extension UICollectionView {
    func reloadAllSections() {
        let sections = self.numberOfSections
        self.reloadSections(IndexSet(integersIn: 0..<sections))
    }
}

