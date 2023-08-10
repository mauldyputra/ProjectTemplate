//
//  Validator.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation
import SwiftDate

class Validator {
    func validate(text: String, with rules: [Rule]) -> String? {
        return rules.compactMap({ $0.check(text) }).first
    }
    
    func validatePhoneToCountryFormat(text: String) -> String {
        var _text = text
        if _text.prefix(1) == "+" {
            _text = String(_text.dropFirst())
        }
        if _text.prefix(1) == "0" {
            _text = String(_text.dropFirst())
        } else if _text.prefix(2) == "62" {
            _text = String(_text.dropFirst(2))
        }
        return "62" + _text
    }
    
    func validatePhone(text: String) -> String {
        var _text = text
        if _text.prefix(1) == "+" {
            _text = String(_text.dropFirst())
        }
        if _text.prefix(1) == "0" {
            _text = String(_text.dropFirst())
        } else if _text.prefix(2) == "62" {
            _text = String(_text.dropFirst(2))
        }
        return "+62" + _text
    }
}

struct Rule {
    // Return nil if matches, error message otherwise
    let check: (String) -> String?

    static let notEmpty = Rule(check: {
        return $0.isEmpty ? "Must not be empty" : nil
    })
    
    static func notEmpty(forField field: String) -> Rule {
        return Rule(check: {
            let valid = !$0.isEmpty
            return valid ? nil : "Anda harus mengisi \(field)"
        })
    }
    
    static func shouldChoose(forField field: String) -> Rule {
        return Rule(check: {
            let valid = !$0.isEmpty
            return valid ? nil : "\(field) harus dipilih"
        })
    }
    
    static func customRule(forField field: String, regex: String) -> Rule {
        return Rule(check: {
            let regex = "'\(regex)'"
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            return predicate.evaluate(with: $0) ? nil : "Format \(field) salah"
        })
    }
    
    static func phoneBetween(forField field: String, _ first: Int, and: Int) -> Rule {
        return Rule(check: {
            let regex = "'^\\.{\(first),\(and)}$'"
            let text = "\($0.formatIDNPhoneWithoutCountryCode())"
            let predicate = NSPredicate(format: "SELF MATCHES \(regex)")
            return predicate.evaluate(with: text) ? nil : "Pastikan \(field) Anda mempunyai \(first)-\(and) digit angka"
        })
    }
    
    static func between(forField field: String, _ first: Int, and: Int) -> Rule {
        return Rule(check: {
            let regex = "'^\\.{\(first),\(and)}$'"
            
            let predicate = NSPredicate(format: "SELF MATCHES \(regex)")
            return predicate.evaluate(with: $0) ? nil : "Pastikan \(field) Anda mempunyai \(first)-\(and) digit angka"
        })
    }
    
    static func atLeastNumber(forField field: String, _ num: Int) -> Rule {
        return Rule(check: {
            let regex = "'^\\.{\(num),}$'"
            
            let predicate = NSPredicate(format: "SELF MATCHES \(regex)")
            return predicate.evaluate(with: $0) ? nil : "\(field) Anda harus terdiri lebih dari \(num) angka"
        })
    }
    
    static func atLeast(forField field: String, _ num: Int) -> Rule {
        return Rule(check: {
            let regex = "'^\\.{\(num),}$'"
            
            let predicate = NSPredicate(format: "SELF MATCHES \(regex)")
            return predicate.evaluate(with: $0) ? nil : "\(field) Anda harus terdiri lebih dari \(num) huruf"
        })
    }
    
    static func notMoreThan(forField field: String, _ num: Int) -> Rule {
        return Rule(check: {
            let regex = "'^\\.{1,\(num)}$'"
            
            let predicate = NSPredicate(format: "SELF MATCHES \(regex)")
            return predicate.evaluate(with: $0) ? nil : "\(field) Anda harus kurang dari \(num) huruf"
        })
    }
    
    static func alphabetOnly(forField field: String) -> Rule {
        return Rule(check: {
            let regex = "^[A-Za-z\\s]*$"
            
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            return predicate.evaluate(with: $0) ? nil : "\(field) harus terdiri dari alfabet saja"
        })
    }
    
    static func numbersOnly(forField field: String) -> Rule {
        return Rule(check: {
            let regex = "^\\d*$"
            
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            return predicate.evaluate(with: $0) ? nil : "\(field) harus terdiri dari angka saja"
        })
    }

    static func validEmail(forField field: String) -> Rule {
        return Rule(check: {
            let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#

            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            return predicate.evaluate(with: $0) ? nil : "\(field) harus dalam format xxx@email.com"
        })
    }

    static func countryCode(forField field: String) -> Rule {
        return Rule(check: {
            let regex = #"^\+\d+.*"#

            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            return predicate.evaluate(with: $0) ? nil : "\(field) harus memiliki kode negara yang valid"
        })
    }
    
    static let validNormalDate = Rule(check: {
        let regex = #"^\d\d?-\d\d?-\d\d\d\d"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? nil : "Format tanggal salah"
    })
    
    static let validLocalPhone = Rule(check: {
        let regex = #"^(62|8|08)\d*$"#

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: $0) ? nil : "Pastikan nomor handphone Anda diawali dengan 8xxxxxxx"
    })
}

// MARK: - Date
extension Rule {
    static func ageIsMoreThan(_ int: Int, dateFormat: String = "dd-MM-yyyy") -> Rule {
        return Rule(check: { text in
            guard let date = Date(text, format: dateFormat, region: SwiftDate.defaultRegion) else { return "Format tanggal salah" }
            let interval = Calendar.current.dateComponents([.year, .month, .day], from: date, to: Date())
            guard let year = interval.year else { return "Tidak dapat menghitung usia" }
            return year >= int ? nil : "Anda harus berumur lebih dari \(int) untuk menggunakan aplikasi"
        })
    }
}
