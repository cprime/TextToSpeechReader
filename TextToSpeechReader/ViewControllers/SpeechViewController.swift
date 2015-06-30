//
//  SpeechViewController.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 6/26/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import UIKit

class SpeechViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var fastForwardButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!

    var article: Article?

    //Mark: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.text =
//            "It’s harder making educational games than you might think.\n\n" +
//            "The market for what are collectively known as learning games was worth $1.8 billion globally in 2013, and it’s expected to grow to over $2.4 billion by 2018. But revenue from selling to schools represents just a small proportion of those figures — $191 million in 2013, rising to $336 million in 2018. With no centralized educational sales platform and limited school budgets often tied up in red tape, it’s tough for dedicated educational game developers to turn a profit.\n\n" +
//            "The U.S. government increasingly recognizes the value of educational games, and a grant scheme is helping encourage more development in this tough climate. Offering up to $1 million in funding, the Small Business Research Program at the Institute of Education Sciences helps support research and development into a variety of education technology products. Over the past 10 years, proposals for educational games have grown from just 5 percent of total applications to around 40 percent.\n\n" +
//            "I spent time talking to three developers — including two who’ve received SBRP grants in the past — to find out what it’s really like at the front lines of the educational game scene right now."
        self.textView.attributedText = NSAttributedString(string: self.article!.body)
        ArticleReader.sharedInstance.article = self.article!

        self.updatePlayPauseButton()
    }

    //Mark: Setup
    func updatePlayPauseButton() {
        if ArticleReader.sharedInstance.speaking {
            self.playPauseButton.setTitle("Pause", forState: .Normal)
        } else {
            self.playPauseButton.setTitle("Play", forState: .Normal)
        }
    }

    //Mark: Button Actions

    @IBAction func didTapPlayPauseButton(sender: AnyObject) {
        if ArticleReader.sharedInstance.speaking {
            ArticleReader.sharedInstance.pauseSpeaking()
        } else {
            ArticleReader.sharedInstance.resumeSpeaking()
        }
        self.updatePlayPauseButton()
    }

}
