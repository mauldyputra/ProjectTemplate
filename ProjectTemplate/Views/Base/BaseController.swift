//
//  BaseController.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 11/08/23.
//

import CoreLocation
import UIKit
import RxSwift
import RxCocoa
import SkeletonView
import SnapKit
import AVFoundation
import Kingfisher

class BaseController: UIViewController {
    @IBOutlet var container: UIStackView?
    
    @IBInspectable var containerBackgroundColor: UIColor? {
        didSet {
            containerView.backgroundColor = containerBackgroundColor
        }
    }
    
    let locationManager = CLLocationManager()
    
    let validator = Validator()
        
    lazy var disposeBag = DisposeBag()
    lazy var notifCenter = NotifCenterManager()
    
    lazy private var containerView = UIView()
    let backgroundNotch = UIView()
    
    var isModalDismissed: Bool = false
    var backHandler: (() -> Void)?
    var searchHandler: (() -> Void)?
    var showBackgroundNotch: Bool = true
    var isNotif: Bool = false
    var isMaintenancePage: Bool = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(isMaintenancePage: Bool) {
        self.init()
        self.isMaintenancePage = isMaintenancePage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @discardableResult
    func dismissModally() -> BaseController {
        self.isModalDismissed = true
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.showBackgroundNotch == true {
            self.setBakcgroundNotch()
        }
        
        if let container = container {
            view.backgroundColor = containerBackgroundColor ?? .white
            
            view.addSubview(containerView)
            containerView.snp.makeConstraints { (make) in
                make.leading.trailing.equalTo(view)
                make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            
            container.removeFromSuperview()
            containerView.addSubview(container)
            container.snp.makeConstraints { (make) in
                make.leading.trailing.top.bottom.equalToSuperview()
            }
        }
        
        #if RELEASE
        if !isSecurityCheckPassed() {
            if environment == .Production || environment == .UAT || environment == .Development{
                presentSimulatorOrJailbroken()
            }
        }
        #endif

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        KingfisherManager.shared.cache.clearCache()
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
    }
    
    deinit {
        print("Deinitialized")
    }
    
    func setBakcgroundNotch() {
        backgroundNotch.backgroundColor = Colors.UI.paleBlack
        
        var topPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        
        backgroundNotch.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: topPadding)
        backgroundNotch.tag = 1999
        self.view.addSubview(backgroundNotch)
    }
    
    @IBAction
    func backPressed() {
        backHandler?()
        if isModalDismissed {
            dismiss(animated: true, completion: nil)
        } else {
            if let nc = navigationController {
                nc.popViewController(animated: true)
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc
    func searchPressed() {
        searchHandler?()
    }
}

extension BaseController {
    // MARK: - Camera Permission
    func checkCameraAccess(isAllowed: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            isAllowed(false)
        case .restricted:
            isAllowed(false)
        case .authorized:
            isAllowed(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { isAllowed($0) }
        @unknown default:
            isAllowed(false)
        }
    }
    
    func presentCameraSettings() {
        let alert = UIAlertController.init(title: "Erha App cannot access your camera", message: "You have to give access to use this feature.", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (_) in
        }))

        alert.addAction(UIAlertAction.init(title: "Settings", style: .default, handler: { (_) in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }))

        present(alert, animated: true)
    }
}
