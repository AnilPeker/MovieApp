//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Anıl Peker on 12.08.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
