//
//  AppDelegate.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-07.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit

@UIApplicationMain
        class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

//        // ナビゲージョンアイテムの文字色
//        UINavigationBar.appearance().tintColor = UIColor.red
//         
//        // ナビゲーションバーのタイトルの文字色
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.blue]
//         
//        // ナビゲーションバーの背景色
//        UINavigationBar.appearance().barTintColor = UIColor.yellow
//         
//        // ナビゲーションバーの背景の透過
//        (UINavigationBar.appearance() as UINavigationBar).setBackgroundImage(UIImage(), for: .default)
//         
//        // ナビゲーションバーの下の影を無くす
//        UINavigationBar.appearance().shadowImage = UIImage()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

