//
//  ReadabilityArticle.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 8/3/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import Foundation

/*

title
domain
author
excerpt
content
lead_image_url
*/

class ReadabilityArticle: NSObject {
    var title: String = ""
    var domain: String = ""
    var author: String = ""
    var summary: String = ""
    var imageURL: NSURL?
    var body = [HTMLToken]()

    init(JSONDictionary: [String:AnyObject]) {
        super.init()

        if let title = JSONDictionary["title"] as? String {
            self.title = title
        }
        if let domain = JSONDictionary["domain"] as? String {
            self.domain = domain
        }
        if let author = JSONDictionary["author"] as? String {
            self.author = author
        }
        if let summary = JSONDictionary["excerpt"] as? String {
            self.summary = summary.stringByReplacingEscapedHTMLCharacters() as String
        }
        if let imageURLString = JSONDictionary["lead_image_url"] as? String {
            self.imageURL = NSURL(string: imageURLString)
        }
        if let bodyHTML = JSONDictionary["content"] as? String {
            var tokenizer = HTMLTokenizer(readers:
                TextTokenReader(),
                ImageTokenReader(),
                HeaderTokenReader()
            )

            self.body = tokenizer.tokenizeHTML(bodyHTML)
        }
    }
}