//
//  HeaderTokenReader.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 8/2/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import Foundation

class HeaderTokenReader : HTMLTokenReader {
    var regexString: String {
        get {
            return "<h2>(.*?)</h2>"
        }
    }

    func isMatchingString(str: String) -> Bool {
        var string = str as NSString

        if string.length < 9 {
            return false
        }

        if string.substringToIndex(4) != "<h2>" {
            return false
        }

        if string.substringFromIndex(string.length - 5) != "</h2>" {
            return false
        }

        return true
    }

    func extractTokenWithString(string: String) -> HTMLToken {
        var trimmedH2Block = string

        var findPTagRegex = NSRegularExpression(pattern: self.regexString, options: .DotMatchesLineSeparators, error: nil)!
        trimmedH2Block = findPTagRegex.stringByReplacingMatchesInString(trimmedH2Block, options: nil, range: NSRange(location: 0, length: count(trimmedH2Block)), withTemplate: "$1")
        trimmedH2Block = trimmedH2Block.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

        var findATagRegex = NSRegularExpression(pattern: "</?a.*?>", options: nil, error: nil)!
        trimmedH2Block = findATagRegex.stringByReplacingMatchesInString(trimmedH2Block, options: nil, range: NSRange(location: 0, length: count(trimmedH2Block)), withTemplate: "")

        trimmedH2Block = trimmedH2Block.stringByReplacingEscapedHTMLCharacters() as String

        return HTMLToken.Text(text: trimmedH2Block)
    }
}