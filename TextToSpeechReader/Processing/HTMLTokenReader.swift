//
//  HTMLTokenReader.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 8/2/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import Foundation

protocol HTMLTokenReader {
    var regexString: String { get }
    func isMatchingString(string: String) -> Bool
    func extractTokenWithString(string: String) -> HTMLToken
}