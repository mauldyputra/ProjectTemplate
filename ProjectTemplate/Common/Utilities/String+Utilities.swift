//
//  String+Utilities.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Atributika
import Foundation
import UIKit
import SwiftDate
import SwiftSoup
import CoreMedia
import JavaScriptCore
import WebKit
import SwiftUI

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

extension String {
    static func trim(_ str: String?) -> String {
        return (str ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func splitBySpace() -> [String] {
        return self.split(separator: " ").map({ String($0) })
    }
    
    func splitByDesh() -> [String] {
        return self.split(separator: "-").map({ String($0) })
    }
    
    func splitByCommaSpace() -> [String] {
        return self.components(separatedBy: ", ").map({ String($0) })
    }
    
    func inserting(separator: String, every n: Int) -> String {
        var result: String = ""
        let characters = Array(self)
        stride(from: 0, to: characters.count, by: n).forEach {
            result += String(characters[$0..<min($0+n, characters.count)])
            if $0+n < characters.count {
                result += separator
            }
        }
        return result
    }
    
    mutating func replaceSubString(startAt: Int, offsetBy: Int, with newString: String) {
        let startIndex = self.index(self.startIndex, offsetBy: startAt)
        let endIndex = self.index(startIndex, offsetBy: offsetBy)
        self.replaceSubrange(startIndex..<endIndex, with: newString)
    }
}

// MARK: - As Number
extension String {
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }

    func formatIDNPhoneWithoutCode() -> String {//8....
        guard self.first != "8",
              self.contains("8"),
              let result = self.split(separator: Character("8"), maxSplits: 1).map(String.init).last
        else {
            return self
        }
        return "8\(result)"
    }
    
    func formatIDNPhoneWithoutCountryCode() -> String {//08...
        let result = self.formatIDNPhoneWithoutCode()
        return "0\(result)"
    }
    
    func formatIDNPhoneWithCountryCode() -> String {//+62....
        let result = self.formatIDNPhoneWithoutCode()
        return "+62\(result)"
    }
    
    func getSecond() -> Double {
        let date = self.toDate("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", region: SwiftDate.defaultRegion)?.date ?? Date()
        return date.timeIntervalSince1970
    }
}

// MARK: - HTML
extension String {
    var parsedHtml: String {
        do {
            let doc: Document = try SwiftSoup.parse(self)
            return try doc.text()
        } catch {
            return self
        }
    }
    
    var stripHtml: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    var toQueryFormat: String {
        return self.replacingOccurrences(of: " ", with: "+")
    }
}

// MARK: - Size
extension String {
    var size: CGSize {
        return size()
    }
    
    public func size(usingFont font: UIFont?) -> CGSize {
        let _font = font ?? UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: _font]
        return self.size(withAttributes: attributes)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

// MARK: String Protocol
extension StringProtocol where Self: RangeReplaceableCollection {
    mutating func insert<S: StringProtocol>(separator: S, every n: Int) {
        for index in indices.dropFirst().reversed()
            where distance(from: indices.first!, to: index).isMultiple(of: n) {
            insert(contentsOf: separator, at: index)
        }
    }
    func inserting<S: StringProtocol>(separator: S, every n: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: n)
        return string
    }
}

// MARK: - Date
extension String {
    var toReadableTimestamp: String {
        let new = String(self.dropLast())
        return new.toDate("yyyy-MM-dd'T'HH:mm:ss.SSS", region: Date.currentRegion)?.toFormat("d MMMM yyyy", locale: Date.usLocale) ?? "n/a"
    }
    
    var toFullDateTime: String {
        let new = String(self.dropLast())
        return new.toDate("yyyy-MM-dd'T'HH:mm:ss.SSS", region: Date.currentRegion)?.toFormat("dd MMM yyyy - hh:mm a", locale: Date.usLocale) ?? "n/a"
    }
    
    var toYearFirstFormat: String {
        return self.toDate("dd-MM-yyyy", region: Date.currentRegion)?.toFormat("yyyy-MM-dd", locale: Date.usLocale) ?? self
    }
    
    var toMonthFirstFormat: String {
        return self.toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ", region: Date.currentRegion)?.toFormat("MMMM d, yyyy", locale: Date.usLocale) ?? self
    }
    
    var toNormalFormat: String {
        return self.toDate("yyyy-MM-dd", region: Date.currentRegion)?.toFormat("dd-MM-yyyy", locale: Date.usLocale) ?? self
    }
    
    var toHourMinutes: String {
        return self.toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ", region: Date.currentRegion)?.toFormat("HH:mm", locale: Date.idLocale) ?? self
    }
    
    var toDateTransaction: String {
        return self.toDateFromUTC(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ") ?? self
    }
    
    var toDateListTransaction: String {
        return self.toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ", region: Date.currentRegion)?.toFormat("dd MMMM yyyy", locale: Date.idLocale) ?? self
    }
    
    var toDateListVoucher: String {
        return self.toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ", region: Date.currentRegion)?.toFormat("dd MMMM yyyy HH:mm:ss", locale: Date.idLocale) ?? self
    }
    
    var toDatePromo: String {
        return self.toDate("yyyy-MM-dd", region: Date.currentRegion)?.toFormat("dd MMMM yyyy", locale: Date.idLocale) ?? self
    }
    
    var toDateRescheduleTeleconsul: String {
        return self.toDateFromUTC(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", toFormat: "yyyy-MM-dd HH:mm:ss") ?? self
    }
    
    var toUTC: String {
        return self.toDate("dd-mm-yyyy", region: Date.currentRegion)?.toFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ", locale: Date.idLocale) ?? self
    }
    
    var toNormalFormatWithSQLFormat: String {
        return self.toISODate(nil, region: Date.currentRegion)?.toFormat("dd-MM-yyyy", locale: Date.usLocale) ?? "n/a"
    }
    
    var toReadableISODate: String {
        return self.toISODate(nil, region: Date.currentRegion)?.toFormat("EEEE, dd MMMM yyyy", locale: Date.usLocale) ?? "n/a"
    }
    
    func timestampToFormat(_ format: String = "EEEE d MMM yyyy, HH:mm zzz") -> String {
        let new = String(self.dropLast())
        return new.toDate("yyyy-MM-dd'T'HH:mm:ss.SSS", region: Date.currentRegion)?.toFormat(format, locale: nil) ?? "n/a"
    }
    
    func toReadableTimeStamp(withHour hour: Bool = true, locale: Locales? = nil) -> String {
        let new = String(self.dropLast())
        let format = hour ? "d MMM yyyy HH:mm:ss" : "d MMMM yyyy"
        return new.toDate("yyyy-MM-dd'T'HH:mm:ss.SSS", region: Date.currentRegion)?.toFormat(format, locale: locale) ?? "n/a"
    }
    
    static func fullTimeToRange(start: String?, end: String?) -> String? {
        return String(start ?? "") + " - " + String(end ?? "")
    }
    
    func toDate(withFormat: String = "yyyy-MM-dd", locale: Locale = Locale(identifier: "id_ID"), timezone : TimeZone? = TimeZone(abbreviation: "GMT+7")) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.timeZone = timezone
        dateFormatter.locale = locale
        return dateFormatter.date(from: self)
    }
    
    func toDate(withFormat: String = "yyyy-MM-dd", locale: Locale = Locale(identifier: "id_ID"), timezone : TimeZone? = TimeZone.current, toFormat: String = "dd MMMM yyyy, HH:mm") -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.timeZone = timezone
            dateFormatter.dateFormat = toFormat
            dateFormatter.locale = locale
        
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func toDateFromUTC(withFormat: String = "yyyy-MM-dd", locale: Locale = Locale(identifier: "id_ID"), timezone : TimeZone? = TimeZone.current, toFormat: String = "dd MMMM yyyy, HH:mm") -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.timeZone = timezone
            dateFormatter.dateFormat = toFormat
            dateFormatter.locale = locale
        
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func convertToDate(format: String, locale: Locale) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale
        guard let date = dateFormatter.date(from: self) else { return nil }
        return date
    }
}

extension String {
    var toISODate: DateInRegion? {
        return self.toISODate(nil, region: Date.currentRegion)
    }
    
    var toTimeDateInRegion: DateInRegion? {
        return self.toDate("HH:mm:ss", region: Date.currentRegion)
    }
    
    var toTimeDate: Date? {
        return self.toDate("HH:mm:ss", region: Date.currentRegion)?.date
    }
    
    var toYearFirstDateFormatInRegion: DateInRegion? {
        return self.toDate("yyyy-MM-dd", region: Date.currentRegion)
    }
    
    var toYearFirstDateFormat: Date? {
        return self.toDate("yyyy-MM-dd", region: Date.currentRegion)?.date
    }
}

extension String {
    var strikethrough: NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

extension NSAttributedString {
    convenience init(htmlString html: String, font: UIFont? = nil, bold: UIFont? = nil, italic: UIFont? = nil, useDocumentFontSize: Bool = true) throws {
        let html = html.replacingOccurrences(of: "img src", with: "img style=\"max-width: \(UIScreen.main.bounds.width - 40)px; height: auto; object-fit: contain;\" src")
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        let data = html.data(using: .utf8, allowLossyConversion: true)
        guard (data != nil), let fontFamily = font?.familyName, let attr = try? NSMutableAttributedString(data: data!, options: options, documentAttributes: nil) else {
            try self.init(data: data ?? Data(html.utf8), options: options, documentAttributes: nil)
            return
        }

        let fontSize: CGFloat? = useDocumentFontSize ? nil : font!.pointSize
        let range = NSRange(location: 0, length: attr.length)
        attr.enumerateAttribute(.font, in: range, options: .longestEffectiveRangeNotRequired) { attrib, range, _ in
            if let htmlFont = attrib as? UIFont {
                let regularFaceName = font!.getTypeface().faceName
                let traits = htmlFont.fontDescriptor.symbolicTraits
                var descrip = htmlFont.fontDescriptor.withFamily(fontFamily).withFace(regularFaceName)

                if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0 {
                    descrip = htmlFont.fontDescriptor.withFamily(fontFamily).withFace(bold?.getTypeface().faceName ?? regularFaceName)
                }

                if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitItalic.rawValue) != 0 {
                    descrip = htmlFont.fontDescriptor.withFamily(fontFamily).withFace(italic?.getTypeface().faceName ?? regularFaceName)
                }

                attr.addAttribute(.font, value: UIFont(descriptor: descrip, size: fontSize ?? htmlFont.pointSize), range: range)
                attr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.darkText/*Colors.UI.dark*/ , range: range)
            }
        }

        self.init(attributedString: attr)
    }
}

extension String {
    //private key prod = 36FFEFC1B8D77C9265F355487E934-private.key
    //private key uat = private.key
    func encryptJS(privateKey: String = environment.keyEncryption, complete: @escaping (_ success: Bool, _ encryptResult: String)->()){
        let jsPath = Bundle.main.path(forResource: "aesEncrypt", ofType: "js")
        if jsPath?.isEmpty == false {
            do{
                let jsScript = try String(contentsOfFile: jsPath ?? "", encoding: String.Encoding.utf8)
                if jsScript.isEmpty == false {
                    let jsContext = JSContext()
                    _ = jsContext?.evaluateScript(jsScript)
                    let helloJSCore = jsContext?.objectForKeyedSubscript("encryption")
                    let result = helloJSCore?.call(withArguments: [self, privateKey])
                    print(result?.toString() ?? "Error")
                    complete(true, result?.toString() ?? "")
                } else {
                    complete(false, "")
                }
            } catch {
                complete(false, "")
            }
        } else {
            complete(false, "")
        }
    }
    
    //private key prod = 36FFEFC1B8D77C9265F355487E934-private.key
    //private key uat = private.key
    func dencryptJS(privateKey: String = environment.keyEncryption, complete: @escaping (_ success: Bool, _ encryptResult: String)->()){
        let jsPath = Bundle.main.path(forResource: "aesEncrypt", ofType: "js")
        if jsPath?.isEmpty == false {
            do{
                let jsScript = try String(contentsOfFile: jsPath ?? "", encoding: String.Encoding.utf8)
                if jsScript.isEmpty == false {
                    let jsContext = JSContext()
                    _ = jsContext?.evaluateScript(jsScript)
                    let helloJSCore = jsContext?.objectForKeyedSubscript("decryption")
                    let result = helloJSCore?.call(withArguments: [self, privateKey])
                    print(result?.toString() ?? "Error")
                    if result?.toBool() == false {
                        complete(false, "")
                    }
                    complete(true, result?.toString() ?? "")
                } else {
                    complete(false, "")
                }
            } catch {
                complete(false, "")
            }
        } else {
            complete(false, "")
        }
    }
}

extension NSMutableAttributedString{
    func bold(_ value:String, font: UIFont) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : font
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String, font: UIFont) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : font,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String, font: UIFont) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  font,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func orangeFont(_ value:String, font: UIFont) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  font,
            .foregroundColor : UIColor.orange
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func blackHighlight(_ value:String, font: UIFont) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  font,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String, font: UIFont) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  font,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
