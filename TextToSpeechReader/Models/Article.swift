//
//  Article.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 6/29/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import Foundation

class Article: NSObject {
    var title: String = ""
    var summary: String = ""
    var body: String = ""
    var imageURL: NSURL?

    init(JSONDictionary: [String:AnyObject]) {
        super.init()

        if let article = JSONDictionary["article"] as? [String:AnyObject] {
            if let title = article["title"] as? String {
                self.title = title
            }
            if let summary = article["description"] as? String {
                self.summary = summary
            }
            if let body = article["body"] as? String {
                self.body = body
            }
            if let imageDictionary = article["image"] as? [String:AnyObject] {
                if let imageURLString = imageDictionary["src"] as? String {
                    self.imageURL = NSURL(string: imageURLString)
                }
            }
        }
    }
}