//
//  MainController.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 11/08/23.
//

import Foundation
import UIKit

let LogoutNotif = Notification.Name("LogoutNotif")

class MainController: BaseController {
    
    private var toMenu: Menu?
    private var idInvoice: String? = ""
    private var idAppointment: String? = ""
    private var hasLogout: Bool = false
    private var onAppear: (() -> Void)?
    
    convenience init(to: Menu?, onAppear: (() -> Void)?) {
        self.init()
        self.onAppear = onAppear
        toMenu = to
    }
    
    convenience init(to: Menu?, idInvoice: String?, idAppointment: String?) {
        self.init()
        
        toMenu = to
        self.idInvoice = idInvoice
        self.idAppointment = idAppointment
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupReachability()
        setupViews()
        
//        observeFCMToken()
        // MARK: OneSignal Push Notif
//        observePushNotification()
        
        notifCenter.observe(LogoutNotif) { [weak self] (note) in
            guard let self = self else { return }
            if !self.hasLogout {
                self.hasLogout = true
                self.doLogout(handler: note.object as? (() -> Void))
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let menu = toMenu {
            goto(menu: menu)
        }
    }
    
    private func setupViews() {
//        let homeVC = HomeController(onAppear: self.onAppear)
//        add(homeVC, to: view)
    }
    
    func goto(menu: Menu) {
        toMenu = nil
        switch menu {
//        case .Account:
//            Router(self).push().goto(.Home_Account)
//        case .Coupon, .NotifCoupon:
//            Router(self).push().goto(.Home_Coupon)
//        case .History, .NotifHistory:
//            if idInvoice != "" || idAppointment != ""{
//                Router(self).push().goto(.Transaction_List_InvoiceId(idInvoice: idInvoice, idAppointment: idAppointment))
//            } else {
//                Router(self).push().goto(.Transaction_List)
//            }
//        case .Inbox, .NotifInbox:
//            Router(self).push().goto(.Home_Inbox)
        default: break
        }
    }
}

extension UIViewController {
    func doLogout(handler: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setIsLoadingWithAlpha(false)
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.reachability?.stopNotifier()
            
             guard let top = self.topController() else { return }
//            if Profiles.userIsLoggin() == false {
//                Router(top).goto(.MainMenu(to: .Home, onAppear: handler))
//            }
        }
    }
}
