//
//  AppDelegate.swift
//  CoreDataTests
//
//  Created by guilherme babugia on 29/04/16.
//  Copyright © 2016 guilherme babugia. All rights reserved.
//

import UIKit
import CoreData
import HealthKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var healthStore = HKHealthStore()
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setAppearance()
        
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
    
    func applicationShouldRequestHealthAuthorization(application: UIApplication) {
        healthStore.handleAuthorizationForExtensionWithCompletion { sucess, error in
            
        }
    }
    
    private func setAppearance() {
        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let appearanceNavigationBar = UINavigationBar.appearance()
        appearanceNavigationBar.translucent = true
        appearanceNavigationBar.barTintColor = UIColor.healthU_Orange()
        appearanceNavigationBar.titleTextAttributes = attrs
        appearanceNavigationBar.tintColor = UIColor.whiteColor()
        
//        let appearanceTabBar = UITabBar.appearance()
//        appearanceTabBar.barTintColor = UIColor.healthU_Orange()
        
        let appearanceTabBarItem = UITabBarItem.appearance()
        appearanceTabBarItem.setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Normal)
        appearanceTabBarItem.setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.healthU_Orange()], forState: .Selected)
        
        let appearanceSegmented = UISegmentedControl.appearance()
        appearanceSegmented.tintColor = UIColor.whiteColor()
    }
    
}