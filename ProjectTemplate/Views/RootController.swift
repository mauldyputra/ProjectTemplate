//
//  RootController.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 14/08/23.
//

import Foundation
import UIKit

private let RootPageNotif = Notification.Name("RootPageNotif")

enum BasePage {
    case onboarding
    case main
    
    var controller: UIViewController {
        switch self {
        case .onboarding:
            let nvc = BaseNavigationController(rootViewController: UIViewController()/*OnboardingController()*/)
            nvc.setNavigationBarHidden(true, animated: false)
            return nvc
        case .main:
            let nvc = BaseNavigationController(rootViewController: MainController())
            nvc.setNavigationBarHidden(true, animated: false)
            return nvc
        }
    }
}

class RootController: UIViewController {
    private let notifCenter = NotifCenterManager()
    
    var currentBasePage: BasePage?
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifCenter.observe(RootPageNotif) { [weak self] (note) in
            guard let self = self,
                let page = note.object as? BasePage else {
                    return
            }
            
            self.children.forEach({ $0.remove() })
            page.controller.view.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.add(page.controller, to: self.view)
                page.controller.view.alpha = 1
            }
            
            self.currentBasePage = page
        }
        
        if Profiles.userIsLoggin() == false {
            if isAppAlreadyLaunchedOnce() {
                RootController.goto(page: .main)
            } else {
                RootController.goto(page: .onboarding)
            }
        } else {
            RootController.goto(page: .main)
        }
    }

    static func goto(page: BasePage) {
        NotifCenterManager.post(RootPageNotif, from: page)
    }
}

// MARK: - Universal Link Handler
extension RootController {
    func handleUniversal(link url: URL) {
        if Profiles.userIsLoggin() == false {
            RootController.goto(page: .main)
            NSLog("UNIVERSAL LINK :: User is not logged in")
            return
        }
        guard currentBasePage == .main,
              let navController = currentBasePage?.controller as? BaseNavigationController,
              let mainController = navController.topViewController as? MainController,
              let topController = mainController.topController()
        else {
            NSLog("UNIVERSAL LINK :: Controller failure - basepage is not MainController")
            return
        }
    }
}
