//
//  ImageTokenReader.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 8/2/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import Foundation

class ImageTokenReader : HTMLTokenReader {
    var regexString: String {
        get {
            return "<div id=\"attachment.*?<a href=\"(.*?)\".*?<img.*?>.*?</a>.*?</div>"
        }
    }

    func isMatchingString(str: String) -> Bool {
        var string = str as NSString

        if string.length < 25 {
            return false
        }

        if string.substringToIndex(19) != "<div id=\"attachment" {
            return false
        }

        if string.substringFromIndex(string.length - 6) != "</div>" {
            return false
        }

        return true
    }

    func extractTokenWithString(string: String) -> HTMLToken {
        var trimmedImgBlock = string

        var findImgTagRegex = NSRegularExpression(pattern: self.regexString, options: .DotMatchesLineSeparators, error: nil)!
        trimmedImgBlock = findImgTagRegex.stringByReplacingMatchesInString(trimmedImgBlock, options: nil, range: NSRange(location: 0, length: count(trimmedImgBlock)), withTemplate: "$1")
        
        return HTMLToken.Image(URL: NSURL(string: trimmedImgBlock)!)
    }
}