//
//  UIImageView+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(url: String?, placeholder: UIImage? = nil, forceDownload force: Bool = false, completion: (() -> Void)? = nil) {
        guard let url = URL(string: url ?? "") else {
            self.image = placeholder
            return
        }
        
        let processor = DownsamplingImageProcessor(size: CGSize(width: self.frame.width, height: self.frame.height))
        
        var options: KingfisherOptionsInfo = [.processor(processor),
                                              .scaleFactor(UIScreen.main.scale),
                                              .transition(.fade(1)),
                                              .cacheOriginalImage,
                                              .loadDiskFileSynchronously]
        if force {
            options.append(.forceRefresh)
        }
        kf.setImage(with: url, placeholder: placeholder, options: options, completionHandler: { _ in
            completion?()
        })
    }
}
