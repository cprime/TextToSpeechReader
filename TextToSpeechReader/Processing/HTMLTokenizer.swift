//
//  HTMLTokenizer.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 8/2/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import Foundation

class HTMLTokenizer {
    var readers: [HTMLTokenReader]

    init() {
        self.readers = [HTMLTokenReader]()
    }

    convenience init(readers: HTMLTokenReader...) {
        self.init();
        self.readers += readers
    }

    func tokenizeHTML(HTMLString: String) -> [HTMLToken] {
        var tokens = [HTMLToken]()

        if !readers.isEmpty {
            var regexString = "|".join(self.readers.map { $0.regexString })

            var regex = NSRegularExpression(pattern: regexString, options: .DotMatchesLineSeparators, error: nil)!
            regex.enumerateMatchesInString(HTMLString, options: NSMatchingOptions(0), range: NSRange(location: 0, length: count(HTMLString))) {
                (result : NSTextCheckingResult!, _, _) in
                if result.range.location != NSNotFound {
                    var trimmedBlock = (HTMLString as NSString).substringWithRange(result.range)

                    for reader in self.readers {
                        if reader.isMatchingString(trimmedBlock) {
                            tokens.append(reader.extractTokenWithString(trimmedBlock))
                            break
                        }
                    }
                }
            }
        }

        return tokens
    }
}