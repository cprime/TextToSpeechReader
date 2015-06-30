//
//  ArticleReader.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 6/29/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import AVFoundation

let ArticleReaderDidStartSpeechUtteranceNotification = "ArticleReaderDidStartSpeechUtteranceNotification"
let ArticleReaderDidFinishSpeechUtteranceNotification = "ArticleReaderDidFinishSpeechUtteranceNotification"
let ArticleReaderDidPauseSpeechUtteranceNotification = "ArticleReaderDidPauseSpeechUtteranceNotification"
let ArticleReaderDidContinueSpeechUtteranceNotification = "ArticleReaderDidContinueSpeechUtteranceNotification"
let ArticleReaderDidCancelSpeechUtteranceNotification = "ArticleReaderDidCancelSpeechUtteranceNotification"

class ArticleReader: NSObject, AVSpeechSynthesizerDelegate {
    static let sharedInstance = ArticleReader()
    var speechSynthesizer: AVSpeechSynthesizer
    var article: Article?

    var speaking : Bool {
        return (self.speechSynthesizer.speaking && !self.speechSynthesizer.paused)
    }

    override init() {
        self.speechSynthesizer = AVSpeechSynthesizer()

        super.init()

        self.speechSynthesizer.delegate = self
    }

    //Mark: Controls

    func stopSpeaking() {
        if self.speechSynthesizer.speaking {
            self.speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        }
    }

    func pauseSpeaking() {
        if self.speechSynthesizer.speaking {
            if !self.speechSynthesizer.paused {
                self.speechSynthesizer.pauseSpeakingAtBoundary(.Word)
            }
        }
    }

    func resumeSpeaking() {
        if self.speechSynthesizer.speaking {
            if self.speechSynthesizer.paused {
                self.speechSynthesizer.continueSpeaking()
            }
        } else {
            var currentUtterance = AVSpeechUtterance(string: self.article!.body)!
            currentUtterance.rate = 0.15
            self.speechSynthesizer.speakUtterance(currentUtterance)
        }
    }

    //Mark: AVSpeechSynthesizerDelegate

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        println(__FUNCTION__)
        NSNotificationCenter.defaultCenter().postNotificationName(ArticleReaderDidStartSpeechUtteranceNotification, object: self)
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        println(__FUNCTION__)
        NSNotificationCenter.defaultCenter().postNotificationName(ArticleReaderDidFinishSpeechUtteranceNotification, object: self)
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didPauseSpeechUtterance utterance: AVSpeechUtterance!) {
        println(__FUNCTION__)
        NSNotificationCenter.defaultCenter().postNotificationName(ArticleReaderDidPauseSpeechUtteranceNotification, object: self)
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didContinueSpeechUtterance utterance: AVSpeechUtterance!) {
        println(__FUNCTION__)
        NSNotificationCenter.defaultCenter().postNotificationName(ArticleReaderDidContinueSpeechUtteranceNotification, object: self)
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didCancelSpeechUtterance utterance: AVSpeechUtterance!) {
        println(__FUNCTION__)
        NSNotificationCenter.defaultCenter().postNotificationName(ArticleReaderDidCancelSpeechUtteranceNotification, object: self)
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance!) {
        var string = utterance.speechString as NSString
        println("\(__FUNCTION__) \(string.substringWithRange(characterRange))")
    }
}
