//
//  UIViewController+Helper.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit
import SnapKit

@nonobjc extension UIViewController {
    // MARK: - Helpers
    func add(_ child: UIViewController, to containerView: UIView? = nil) {
        addChild(child)
        if let cv = containerView {
            cv.addSubview(child.view)
            child.view.snp.makeConstraints { (make) in
                make.leading.trailing.top.bottom.equalToSuperview()
            }
        }
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func topController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            return topController
        }
        return nil
    }
    
    func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            return false
        }
    }
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
        resignFirstResponder()
    }
    
    // MARK: - Presenters
    func presentFull(viewControllerToPresent vc: UIViewController, animated: Bool, completion: (() -> Void)?) {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: animated, completion: completion)
    }
    
    @objc func goBack() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Customs
    func setIsLoadingWithAlpha(_ isLoading: Bool, _ alpha: Float = 0.7, title: String? = nil) {
        let loadingView = UIView.nib(withType: LoadingView.self)
        loadingView.tag = 333
        loadingView.title = title
        
        if isLoading {
            guard !(view.subviews.contains(where: { $0.tag == 333 })) else { return }
            
            view.isUserInteractionEnabled = false
            view.addSubview(loadingView)
            loadingView.snp.makeConstraints({ (make) in
                make.leading.trailing.top.bottom.equalTo(view)
            })
            loadingView.contentView?.alpha = CGFloat(alpha)
        } else {
            view.isUserInteractionEnabled = true
            view.subviews.forEach { (v) in
                if v.tag == 333 {
                    v.removeFromSuperview()
                }
            }
        }
    }
}

