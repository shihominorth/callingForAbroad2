//
//  AppDelegate.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-07.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces

@UIApplicationMain
        class AppDelegate: UIResponder, UIApplicationDelegate {
    
//    let apiKey = "AIzaSyAy1cHc3umfq1DHnqckpJCMK7xlfzhuXeI"
   
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "callingForAbroad")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            print(storeDescription)
            if let error = error as NSError? {
                fatalError("Unsolved error: \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch  {
                let error = error as NSError
                fatalError("Unsolved error: \(error), \(error.userInfo)")
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let apiKey = KeyManager().getValue(key:"apiKey") as? String {
               GMSServices.provideAPIKey(apiKey)
               GMSPlacesClient.provideAPIKey(apiKey)
           }
        
        // Override point for customization after application launch.
        
        
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

