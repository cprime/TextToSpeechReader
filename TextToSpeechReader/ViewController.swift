//
//  ViewController.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 6/26/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let feedTableViewCellIdentifier = "feedTableViewCellIdentifier"
    let readabilityBaseURLString = "https://readability.com"
    let readabilityToken = "d10a79aecb15e09d1ab14c596509e9ab10c7e436"

    @IBOutlet weak var feedTableView: UITableView!
    var feedURLs: [NSURL]

    //Mark: UIViewController

    required init(coder aDecoder: NSCoder) {
        self.feedURLs = [NSURL]()

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.feedTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: feedTableViewCellIdentifier)

        self.feedURLs = [
            NSURL(string: "http://venturebeat.com/2015/06/24/making-educational-games-is-tough-especially-if-you-want-to-make-money/view-all/")!,
            NSURL(string: "http://phenomena.nationalgeographic.com/2015/06/24/raindrops-keep-falling-on-my-head-a-mosquitos-lament/")!,
            NSURL(string: "http://venturebeat.com/2015/06/22/blizzard-will-wrap-up-17-years-of-storytelling-in-starcraft-ii-legacy-of-the-void/view-all/")!,
        ]
    }

    //Mark: Helpers

    func readabilityURLWithContentURL(contentURL: NSURL) -> NSURL {
        //TODO: Try http://juicer.herokuapp.com/api/article?url=http://www.bbc.co.uk/news/world-africa-16377824 instead

        var readabilityAPIURL = NSURL(string: readabilityBaseURLString)
        var path = "api/content/v1/parser?url=\(contentURL.absoluteString!)&token=\(readabilityToken)"
        return NSURL(string: path, relativeToURL: readabilityAPIURL)!
    }

    //Mark: UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedURLs.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.feedTableView.dequeueReusableCellWithIdentifier(feedTableViewCellIdentifier, forIndexPath:indexPath) as! UITableViewCell
        var URL = self.feedURLs[indexPath.row]

        cell.textLabel?.text = "\(URL)"

        return cell
    }

    //Mark: UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var URL = self.feedURLs[indexPath.row]
        URL = self.readabilityURLWithContentURL(URL)
        println(URL.absoluteString!)

        SVProgressHUD.showWithStatus("Downloading...", maskType: .Gradient)
        Alamofire.request(.GET, URL)
            .responseJSON { (_, _, JSON, error) in
                if (error != nil) {
                    println(error)
                    SVProgressHUD.showSuccessWithStatus("Download Failed!")
                } else {
                    if let text = JSON!["content"] as? String {
                        println(text)
//                        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("SpeechViewController") as! SpeechViewController
//                        vc.text = text;
//                        self.navigationController?.pushViewController(vc, animated: true)
                        var tokenizer = HTMLTokenizer();
                        tokenizer.parseHTMLString(text);
                    }
                    SVProgressHUD.showSuccessWithStatus("Download Complete!")
                }
        }

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

