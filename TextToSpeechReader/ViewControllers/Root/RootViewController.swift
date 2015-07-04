//
//  RootViewController.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 7/4/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import UIKit
import MFSideMenu

class RootViewController: UIViewController {
    var containerViewController: MFSideMenuContainerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        var centerViewController = ReadingListViewController()
        self.addMenuButtonWithViewController(centerViewController)

        var navigationController = UINavigationController(rootViewController: centerViewController)

        var sideMenuViewController = SideMenuViewController(nibName: "SideMenuViewController", bundle: NSBundle.mainBundle());

        self.containerViewController = MFSideMenuContainerViewController.containerWithCenterViewController(
            navigationController,
            leftMenuViewController: sideMenuViewController,
            rightMenuViewController: nil
        )
        self.containerViewController.panMode = MFSideMenuPanModeNone

        self.addChildViewController(self.containerViewController)
        self.view.addSubview(self.containerViewController.view)

        centerViewController.view.backgroundColor = UIColor.redColor()
        sideMenuViewController.view.backgroundColor = UIColor.yellowColor()

        /*
        UIViewController *centerViewController = [[UIViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];

        self.sideMenuViewController = [self createSideMenuViewController];

        self.containerViewController = [MFSideMenuContainerViewController containerWithCenterViewController:navigationController
        leftMenuViewController:self.sideMenuViewController
        rightMenuViewController:nil];
        self.containerViewController.panMode = MFSideMenuPanModeNone;
        self.containerViewController.view.backgroundColor = [UIColor RMBackgroundGray];

        self.containerViewController.leftMenuWidth = [[UIScreen mainScreen] bounds].size.width - kRMWidthOfRightMenuBar;

        [self addChildViewController:self.containerViewController];
        [self.view addSubview:self.containerViewController.view];
*/
    }

    func addMenuButtonWithViewController(viewcontroller: UIViewController) {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Menu", forState: .Normal)
        button.addTarget(self, action: "toggleSideMenu", forControlEvents: .TouchUpInside)
        button.sizeToFit()
        viewcontroller.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }

    func toggleSideMenu() {
        self.containerViewController.toggleLeftSideMenuCompletion {
            println("Finished Toggling")
        }
    }

}
