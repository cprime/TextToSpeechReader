//
//  HTMLTokenizerTests.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 6/26/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import UIKit
import XCTest

class HTMLTokenizerTests: XCTestCase {
    var tokenizer: HTMLTokenizer?

    override func setUp() {
        self.tokenizer = HTMLTokenizer(readers:
            TextTokenReader(),
            ImageTokenReader(),
            HeaderTokenReader()
        )
    }

    func testSomething() {
        let makingPath = NSBundle(forClass: self.dynamicType).pathForResource("making-educational-games", ofType: "json")!
        let makingData = NSData(contentsOfFile: makingPath)!
        let makingJSON = NSJSONSerialization.JSONObjectWithData(makingData, options: nil, error: nil) as! [String: AnyObject]
        var makingHTML = makingJSON["content"] as! String

        if let tokens = self.tokenizer?.tokenizeHTML(makingHTML) {
            for token in tokens {
                switch token {
                case let .Text(text):
                    println(text)
                case let .Image(URL):
                    println(URL.absoluteString)
                }
                println()
            }
        }
    }
}
