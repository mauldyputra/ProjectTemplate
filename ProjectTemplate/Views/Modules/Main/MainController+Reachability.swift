//
//  MainController+Reachability.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 14/08/23.
//

import Foundation
import Reachability
import RxReachability
import RxSwift

extension MainController {
    
//    static var errorModal = InfoDrawerController(message: "You are not connected to the internet. Please check your connection.",
//                                                 buttonTitle: "RETRY",
//                                                 action: { MainController.retryHandler() })
    
    func setupReachability() {
        Reachability.rx.isConnected
            .subscribe(onNext: {
                self.hideErrorConnection()
            })
            .disposed(by: disposeBag)
        
        Reachability.rx.isDisconnected
            .subscribe(onNext: {
                self.showErrorConnection()
            })
            .disposed(by: disposeBag)
    }
    
    private func hideErrorConnection() {
//        MainController.errorModal.dismiss(animated: true, completion: nil)
    }
    
    private func showErrorConnection() {
//        guard let vc = self.topController(),
//            !(vc is VideoCallController),
//            !(vc is VideoCallScheduledController), // don't show in video call page
//            !(vc is CallDoctorController),
//            !(vc is CallScheduledViewController) // don't show in reconnection page
//        else { return }
//        Presenter(on: vc).showModalController(MainController.errorModal, dismissable: false)
    }
    
    private static func retryHandler() {
//        let r = Reachability()
//        switch r.connection {
//        case .cellular, .wifi:
//            do {
//                try MainController().hideErrorConnection()
//            } catch {
//                print("Error in hideErrorConnection: \(error)")
//            }
//        default:
//            break
//        }
    }

}
