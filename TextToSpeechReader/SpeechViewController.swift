//
//  SpeechViewController.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 6/26/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechViewController: UIViewController, AVSpeechSynthesizerDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var fastForwardButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!

    var speechSynthesizer: AVSpeechSynthesizer
    var text: String?

    //Mark: UIViewController

    required init(coder aDecoder: NSCoder) {
        self.speechSynthesizer = AVSpeechSynthesizer()

        super.init(coder: aDecoder)

        self.speechSynthesizer.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.text =
            "It’s harder making educational games than you might think.\n\n" +
            "The market for what are collectively known as learning games was worth $1.8 billion globally in 2013, and it’s expected to grow to over $2.4 billion by 2018. But revenue from selling to schools represents just a small proportion of those figures — $191 million in 2013, rising to $336 million in 2018. With no centralized educational sales platform and limited school budgets often tied up in red tape, it’s tough for dedicated educational game developers to turn a profit.\n\n" +
            "The U.S. government increasingly recognizes the value of educational games, and a grant scheme is helping encourage more development in this tough climate. Offering up to $1 million in funding, the Small Business Research Program at the Institute of Education Sciences helps support research and development into a variety of education technology products. Over the past 10 years, proposals for educational games have grown from just 5 percent of total applications to around 40 percent.\n\n" +
            "I spent time talking to three developers — including two who’ve received SBRP grants in the past — to find out what it’s really like at the front lines of the educational game scene right now."
        self.textView.attributedText = NSAttributedString(string: self.text!)

        self.updatePlayPauseButton()
    }

    //Mark: Setup

    /*
             Play  NotPlay
       Pause Play  --
    NotPause Pause Play
    */
    func updatePlayPauseButton() {
        if self.speechSynthesizer.speaking && !self.speechSynthesizer.paused {
            self.playPauseButton.setTitle("Pause", forState: .Normal)
        } else {
            self.playPauseButton.setTitle("Play", forState: .Normal)
        }
    }

    func highlightCurrentWordAtRange(characterRange: NSRange) {
        var highlight = NSMutableAttributedString(string: self.text!)
        highlight.setAttributes([ NSBackgroundColorAttributeName : UIColor.yellowColor() ], range: characterRange)
        self.textView.attributedText = highlight
    }

    //Mark: Button Actions

    /*
             Play  NotPlay
       Pause Play  --
    NotPause Pause Start
    */
    @IBAction func didTapPlayPauseButton(sender: AnyObject) {
        if self.speechSynthesizer.speaking && self.speechSynthesizer.paused {
            self.speechSynthesizer.continueSpeaking()
        } else if self.speechSynthesizer.speaking {
            self.speechSynthesizer.pauseSpeakingAtBoundary(.Word)
        } else if !self.speechSynthesizer.speaking {
            var utterance = AVSpeechUtterance(string: self.text)
            utterance.rate = 0.15
            self.speechSynthesizer.speakUtterance(utterance)
        }
    }

    //Mark: AVSpeechSynthesizerDelegate

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        println(__FUNCTION__)
        self.updatePlayPauseButton()
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        println(__FUNCTION__)
        self.updatePlayPauseButton()
        self.highlightCurrentWordAtRange(NSRange(location: 0, length: 0))
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didPauseSpeechUtterance utterance: AVSpeechUtterance!) {
        println(__FUNCTION__)
        self.updatePlayPauseButton()
        self.highlightCurrentWordAtRange(NSRange(location: 0, length: 0))
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didContinueSpeechUtterance utterance: AVSpeechUtterance!) {
        println(__FUNCTION__)
        self.updatePlayPauseButton()
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didCancelSpeechUtterance utterance: AVSpeechUtterance!) {
        println(__FUNCTION__)
        self.updatePlayPauseButton()
        self.highlightCurrentWordAtRange(NSRange(location: 0, length: 0))
    }

    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance!) {
        var string = utterance.speechString as NSString
        println("\(__FUNCTION__) \(string.substringWithRange(characterRange))")
        self.highlightCurrentWordAtRange(characterRange)
    }

}
