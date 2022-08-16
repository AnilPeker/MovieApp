//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Anıl Peker on 12.08.22.
//

import UIKit
import Bagel
import SwiftyBeaver
let log = SwiftyBeaver.self

/*
 iOS Version: 11.0 +
 Architecture: MVVM-C
 Project Style: Only Programatic
 Package Manager: CocoaPods
 Dependencies:
    KingFisher - Image fetching and caching
    Bagel - Service Logger
    Lottie - Animator
 Network Layer: Own Creature
 
 While developing, attention was paid to:
    - Testable code
    - Protocol Oriented
    - SOLID Principles
    - Foldering
    - Reusibility
    - Readiblity
 
 */



@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Bagel.start()
        appStart()
        return true
    }
}

extension AppDelegate {
    private func appStart() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator.start()
    }
}
