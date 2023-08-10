//
//  Snackbar.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

public final class Snackbar {
    public enum `Type` {
        case Error
        case Success
        case Info
        
        var color: UIColor {
            switch self {
            case .Error: return .red //Colors.Background.red
            case .Success: return .green //Colors.Background.green
            case .Info: return .blue //Colors.Background.blue
            }
        }
    }
    
    private static var pool = [TTGSnackbar]()
    
    // MARK: - Public Methods
    public static func show(title: String, subtitle: String, type: Type, duration: TTGSnackbarDuration = .middle) {
        let vi = UIView.nib(withType: SnackbarView.self)
        vi.configure(title: title, subtitle: subtitle, color: type.color)
        
        let snackbar = TTGSnackbar(customContentView: vi, duration: duration)
        snackbar.tag = 1669
        snackbar.backgroundColor = .clear
        snackbar.shadowColor = .clear
        snackbar.contentInset = .zero
        snackbar.animationType = .slideFromTopBackToTop
        snackbar.onTapBlock = { snackbar in
            snackbar.dismiss()
        }
        
        // Break 401 error
        if subtitle.lowercased().contains("unauthorized")
            || subtitle.lowercased() == "Anda harus login terlebih dahulu"
            || subtitle.lowercased().contains("token") {
            return
        }
        
        // Break request error
        if subtitle.lowercased().contains("Telah terjadi kesalahan, silahkan coba beberapa saat lagi") {
            return
        }
        
        snackbar.show()
    }
    
    public static func showError(_ err: Error?) {
        if let err = err {
            var subtitle = err.localizedDescription
            if subtitle.contains("request timed out") {
                subtitle = "Mohon cek kembali koneksi Anda"
            } else if subtitle.contains("URL") {
                return
            }
            Snackbar.show(title: "Oops!", subtitle: subtitle, type: .Error)
        }
    }
    
    public static func showError(title: String = "Oops!", _ string: String) {
        var subtitle = string
        if string.contains("request timed out") {
            subtitle = "Mohon cek kembali koneksi Anda"
        }
        Snackbar.show(title: title, subtitle: subtitle, type: .Error)
    }
    
    public static func showTokenExpirationError() {
        Snackbar.show(title: "Oops!", subtitle: "Maaf sesi Anda sudah habis. Silahkan login terlebih dahulu", type: .Error)
    }
}

