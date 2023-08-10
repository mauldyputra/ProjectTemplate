//
//  String+URLEncode.swift
//  ProjectTemplate
//
//  Created by Mauldy Putra on 10/08/23.
//

import Foundation

extension String {
    
  public func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~/?"
    let allowedCharacterSet = NSMutableCharacterSet.alphanumeric()
    allowedCharacterSet.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet)
  }
    
  public func stringByAddingPercentEncodingForFormData(plusForSpace: Bool=false) -> String? {
    let unreserved = "*-._"
    let allowedCharacterSet = NSMutableCharacterSet.alphanumeric()
    allowedCharacterSet.addCharacters(in: unreserved)
    
    if plusForSpace {
        allowedCharacterSet.addCharacters(in: " ")
    }
    
    var encoded = addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet)
    if plusForSpace {
        encoded = encoded?.replacingOccurrences(of: " ", with: "+")
    }
    return encoded
  }
}
