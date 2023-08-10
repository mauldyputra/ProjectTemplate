//
//  SharingManager.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import MessageUI
import UIKit

public final class SharingManager {
    static var shared : SharingManager = {
        let manager  = SharingManager()
        return manager
    }()
    
    // MARK: - Phone
    func makePhoneCall(number: String) {
        let result = number.filter("0123456789".contains)
        
        if let url = URL(string: "tel://\(result)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            Snackbar.showError("Gagal melakukan panggilan")
        }
    }

    // MARK: - WA
    func shareToWhatsapp(text: String, toNumber number: String? = nil) {
        guard let strEncoded = text.stringByAddingPercentEncodingForRFC3986() else {
            Snackbar.showError("Tidak dapat membagikan ke WhatsApp")
            return
        }
        var urlStr = "https://wa.me/"
        if let number = number { urlStr += "\(number)" }
        urlStr += "?text=\(strEncoded)"
        let url  = URL(string: urlStr)
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:]) { (success) in
                if !success {
                    Snackbar.showError("WhatsApp tidak dapat diakses")
                    NSLog("[ERROR] Share::Error accessing WhatsApp")
                }
            }
        } else {
            Snackbar.showError("WhatsApp tidak tersedia")
        }
    }
    
    func contactWhatsapp(number: String, message: String) {
        guard let strEncoded = message.stringByAddingPercentEncodingForRFC3986() else {
            Snackbar.showError("Tidak dapat membuka WhatsApp")
            return
        }
        var urlStr = "https://wa.me/"
        urlStr += "\(number.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: ""))"
        urlStr += "?text=\(strEncoded)"
        let url  = URL(string: urlStr)
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:]) { (success) in
                if !success {
                    Snackbar.showError("WhatsApp tidak dapat diakses")
                    NSLog("[ERROR] Share::Error accessing WhatsApp")
                }
            }
        } else {
            Snackbar.showError("WhatsApp tidak tersedia")
        }
    }
    
    // MARK: - SMS
    func shareToSMS(number: String, text: String, from: UIViewController, delegate: MFMessageComposeViewControllerDelegate) {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = delegate
        
        // Configure the fields of the interface.
        composeVC.recipients = [number]
        composeVC.body = text
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            from.present(composeVC, animated: true, completion: nil)
        } else {
            Snackbar.showError("Pesan tidak dapat diakses")
            NSLog("[ERROR] Share::Error accessing message")
        }
    }
    
    // MARK: - Activity View
    func shareToMore(text: String, in vc: UIViewController) {
        let activity = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activity.excludedActivityTypes = [.postToFacebook, .saveToCameraRoll, .assignToContact, .addToReadingList, .airDrop, .openInIBooks, .postToFlickr, .postToTencentWeibo]
        vc.present(activity, animated: true, completion: nil)
    }
}
