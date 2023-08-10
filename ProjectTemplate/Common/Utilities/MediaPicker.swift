//
//  MediaPicker.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit
import YPImagePicker

public final class MediaPicker {
    private let viewController: UIViewController
    
    required init(_ vc: UIViewController) {
        self.viewController = vc
    }
    
    // MARK: - Methods
    final func singleImage(withLibrary: Bool = true, useFrontCamera: Bool = false, onComplete: @escaping ((UIImage?) -> Void)) {
        var conf = YPImagePickerConfiguration()
        if withLibrary {
            conf.screens = [.photo, .library]
        } else {
            conf.screens = [.photo]
        }
        conf.usesFrontCamera = useFrontCamera
        conf.showsPhotoFilters = false
        conf.startOnScreen = .photo
        conf.library.maxNumberOfItems = 1
        conf.library.mediaType = .photo
        conf.colors.tintColor = .systemBlue
        conf.onlySquareImagesFromCamera = false
        
        let picker = YPImagePicker(configuration: conf)
        picker.didFinishPicking { [unowned picker] (media, canceled) in
            if let photo = media.singlePhoto {
                onComplete(photo.image)
            } else {
                onComplete(nil)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        viewController.present(picker, animated: true, completion: nil)
    }
    
    final func singleMedia(onComplete: @escaping ((UIImage?, URL?) -> Void)) {
        var conf = YPImagePickerConfiguration()
        conf.screens = [.photo, .library, .video]
        conf.showsPhotoFilters = false
        conf.showsVideoTrimmer = false
        conf.startOnScreen = .photo
        conf.library.maxNumberOfItems = 1
        conf.library.mediaType = .photoAndVideo
        conf.video.fileType = .mp4
        conf.video.recordingTimeLimit = 600.0
        conf.video.libraryTimeLimit = 600.0
        conf.video.minimumTimeLimit = 3.0
        conf.colors.tintColor = .systemBlue
        conf.onlySquareImagesFromCamera = false
        
        let picker = YPImagePicker(configuration: conf)
        picker.didFinishPicking { [unowned picker] (media, canceled) in
            if let media = media.singleVideo {
                onComplete(media.thumbnail, media.url)
            } else if let media = media.singlePhoto {
                onComplete(media.image, nil)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        viewController.present(picker, animated: true, completion: nil)
    }
    
    final func multipleImage() {
        var conf = YPImagePickerConfiguration()
        conf.screens = [.photo, .library, .video]
        conf.showsPhotoFilters = false
        conf.startOnScreen = .photo
        conf.library.maxNumberOfItems = 0
        conf.library.mediaType = .photoAndVideo
        conf.colors.tintColor = .systemBlue
        conf.onlySquareImagesFromCamera = false
        
        let picker = YPImagePicker(configuration: conf)
        picker.didFinishPicking { [unowned picker] (media, canceled) in
            picker.dismiss(animated: true, completion: nil)
        }
        
        viewController.present(picker, animated: true, completion: nil)
    }
}
