//
//  SideMenuViewController.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 7/4/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import UIKit

enum SideMenuNavigation : Int {
    case ReadingList = 0
    case Archive

    func displayName() -> String {
        switch self {
            case .ReadingList :
                return "ReadingList"
            case .Archive :
                return "Archive"
        }
    }

    static var count: Int {
        var max: Int = 0
        while let _ = self(rawValue: ++max) {}
        return max
    }
}

protocol SideMenuViewControllerDelegate {
    func didTapNavigationWithNavigation(navigation: SideMenuNavigation)
}

class SideMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let SideMenuTableViewCellIdentifier = "SideMenuTableViewCell"

    @IBOutlet weak var sideMenuTableView: UITableView!

    var delegate: SideMenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.sideMenuTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCellIdentifier)
    }

    //Mark: UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideMenuNavigation.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.sideMenuTableView.dequeueReusableCellWithIdentifier(SideMenuTableViewCellIdentifier, forIndexPath:indexPath) as! UITableViewCell

        var navigation = SideMenuNavigation(rawValue: indexPath.row)!
        cell.textLabel?.text = navigation.displayName()

        return cell
    }

    //Mark: UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // tell delegate
    }

}
