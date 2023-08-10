//
//  Router.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import UIKit

public final class Router {
    private let viewController: UIViewController
    
    private var modally: Bool = true
    private var fullPresent: Bool = false
    
    private var useBaseNavigation: Bool = false
    private var rootView: Bool = false
    
    required init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // Self modifier
    func usingBaseNav() -> Router {
        self.useBaseNavigation = true
        return self
    }
    
    func push() -> Router {
        self.modally = false
        return self
    }
    
    func full() -> Router {
        self.fullPresent = true
        return self
    }
    
    func root() -> Router {
        self.rootView = true
        return self
    }
    
    func popToLastVisit(completion: (() -> Void)? = nil) {
        let arrController = viewController.navigationController!.viewControllers as Array
        if arrController.count > 0 {
            let loginFiler = arrController.filter{$0.nibName == "LoginController"}
            let registerFiler = arrController.filter{$0.nibName == "RegisterKtpController"}
            if loginFiler.count > 0 {
                // From Login
                guard let indexLogin = arrController.firstIndex(where: { $0.nibName == "LoginController" } ) else { return }
                viewController.navigationController!.popToViewController(arrController[indexLogin - 1], animated: true)
                completion?()
                return
            }
            if registerFiler.count > 0 {
                // From Register
                guard let indexRegistration = arrController.firstIndex(where: { $0.nibName == "RegisterKtpController" } ) else { return }
                viewController.navigationController!.popToViewController(arrController[indexRegistration - 1], animated: true)
                completion?()
                return
            }
        }
        viewController.navigationController?.popViewController(animated: true)
    }
    
//    func open(_ vc: UIViewController, _ animationOpen: Bool? = true, isNeedLogin: Bool = false, isPopupLoginRegister: Bool = false) {
//        let animationOpen = animationOpen ?? true
//
//        if isNeedLogin == true {
//            if Profiles.userIsLoggin() == false {
//                if isPopupLoginRegister == true {
//                    let loginVC = LoginRegisterPopupController()
//                    loginVC.currentVc = viewController
//                    viewController.present(loginVC, animated: true, completion: nil)
//                } else {
//                    //new VC LoginRegisterPopupController
//                    let loginVC = LoginController(onAppear: nil, snackBar: nil)
//                    viewController.presentFull(viewControllerToPresent: loginVC, animated: false, completion: nil)
//                }
//                return
//            }
//        }
//
//        if rootView {
//            if useBaseNavigation {
//                if vc is BaseController {
//                    (vc as! BaseController).isModalDismissed = true
//                    let nvc = BaseNavigationController(rootViewController: vc)
//                    nvc.setNavigationBarHidden(true, animated: true)
//                    viewController.presentFull(viewControllerToPresent: nvc, animated: animationOpen, completion: nil)
//                }
//            } else {
//                viewController.navigationController?.popToRootViewController(animated: animationOpen)
//                viewController.navigationController?.pushViewController(vc, animated: animationOpen)
//            }
//        } else {
//            if modally {
//                if useBaseNavigation {
//                    if vc is BaseController {
//                        (vc as! BaseController).isModalDismissed = true
//                        let nvc = BaseNavigationController(rootViewController: vc)
//                        nvc.setNavigationBarHidden(true, animated: true)
//                        viewController.presentFull(viewControllerToPresent: nvc, animated: animationOpen, completion: nil)
//                    }
//                } else {
//                    if fullPresent {
//                        viewController.presentFull(viewControllerToPresent: vc, animated: animationOpen, completion: nil)
//                    } else {
//                        viewController.present(vc, animated: true, completion: nil)
//                    }
//                }
//            } else {
//                viewController.navigationController?.pushViewController(vc, animated: animationOpen)
//            }
//        }
//    }
}
