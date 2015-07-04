//
//  AppDelegate.swift
//  TextToSpeechReader
//
//  Created by Colden Prime on 6/26/15.
//  Copyright (c) 2015 IntrepidPursuits. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        IPBackgroundAudioManager.sharedManager().startSessionWithCategory(AVAudioSessionCategoryPlayback, error: nil)

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = RootViewController()
        self.window?.makeKeyAndVisible()

        return true
    }

    func applicationWillTerminate(application: UIApplication) {
        IPBackgroundAudioManager.sharedManager().endSession()
    }


}

