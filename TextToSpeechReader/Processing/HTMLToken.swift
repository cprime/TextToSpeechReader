//
//  HTMLToken.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 8/2/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import Foundation

enum HTMLToken {
    case Text(text: String)
    case Image(URL: NSURL)
}