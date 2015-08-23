//
//  NSStringHTMLExtension.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 8/2/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import Foundation

extension NSString {
    func stringByReplacingEscapedHTMLCharacters() -> NSString {
        var string = NSString(string: self)

        var regex = NSRegularExpression(pattern: "&#x([a-f0-9]+);", options: .CaseInsensitive, error: nil)!
        while true {
            if let result = regex.firstMatchInString(string as String, options: nil, range: NSRange(location: 0, length: string.length)) {
                var match = string.substringWithRange(result.range)
                var hexString = regex.stringByReplacingMatchesInString(match as String, options: nil, range: NSRange(location: 0, length: count(match)), withTemplate: "$1") as NSString
                if let uint = hexString.uintWithHexString(16) {
                    var swapString = String(Character(UnicodeScalar(uint as UInt32)))
                    string = string.stringByReplacingOccurrencesOfString(match as String, withString: swapString)
                }
            } else {
                break
            }
        }

        string = string.stringByReplacingOccurrencesOfString("&hellip;", withString: "...")

        return string
    }

    func uintWithHexString(radix: UInt32) -> UInt32? {
        let digits = "0123456789abcdefghijklmnopqrstuvwxyz"
        var result = UInt32(0)
        for digit in self.lowercaseString {
            if let range = digits.rangeOfString(String(digit)) {
                let val = UInt32(distance(digits.startIndex, range.startIndex))
                if val >= radix {
                    return nil
                }
                result = result * radix + val
            } else {
                return nil
            }
        }
        return result
    }
}