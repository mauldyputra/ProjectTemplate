//
//  Pasteboard.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import UIKit

public final class Pasteboard {
    static func copy(text: String?, successText: String = "Copied") {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
        
//        Snackbar.show(title: "Success", subtitle: successText, type: .Info)
    }
}

