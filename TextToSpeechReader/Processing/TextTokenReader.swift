//
//  TextTokenReader.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 8/2/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import Foundation

class TextTokenReader : HTMLTokenReader {
    var regexString: String {
        get {
            return "<p>(.*?)</p>"
        }
    }

    func isMatchingString(str: String) -> Bool {
        var string = str as NSString

        if string.length < 7 {
            return false
        }

        if string.substringToIndex(3) != "<p>" {
            return false
        }

        if string.substringFromIndex(string.length - 4) != "</p>" {
            return false
        }

        return true
    }

    func extractTokenWithString(string: String) -> HTMLToken {
        var trimmedPBlock = string

        trimmedPBlock = trimmedPBlock.stringByReplacingOccurrencesOfString("<br>", withString: "\n", options: nil, range: nil)

        var findPTagRegex = NSRegularExpression(pattern: self.regexString, options: .DotMatchesLineSeparators, error: nil)!
        trimmedPBlock = findPTagRegex.stringByReplacingMatchesInString(trimmedPBlock, options: nil, range: NSRange(location: 0, length: count(trimmedPBlock)), withTemplate: "$1")
        trimmedPBlock = trimmedPBlock.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

        var findATagRegex = NSRegularExpression(pattern: "</?a.*?>", options: nil, error: nil)!
        trimmedPBlock = findATagRegex.stringByReplacingMatchesInString(trimmedPBlock, options: nil, range: NSRange(location: 0, length: count(trimmedPBlock)), withTemplate: "")

        trimmedPBlock = trimmedPBlock.stringByReplacingEscapedHTMLCharacters() as String

        return HTMLToken.Text(text: trimmedPBlock)
    }
}