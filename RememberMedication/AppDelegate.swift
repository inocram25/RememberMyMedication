//
//  AppDelegate.swift
//  CoreDataTests
//
//  Created by guilherme babugia on 29/04/16.
//  Copyright © 2016 guilherme babugia. All rights reserved.
//

import UIKit
import CoreData
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate{
    
    var window: UIWindow?
    var medicines = [[String:String]]()
    
    //session for watch recieving messages medication
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {

        print("Session AppDelegate")
        if let type = message["messageType"] as? String where type == "medicine" {
            
            let medicationCD = MedicationDAO.returnAll()! as [MedicationCD]
            
            for medicine in medicationCD {
                let medDictionary = ["name" : medicine.name,"dosage" : medicine.dosage,
                                     "date" : medicine.startDate.toString,"patient" : medicine.patient]
                medicines.append(medDictionary)
            }

            replyHandler(["medicines" : medicines])
        }
    }

    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setAppearance()
        
        //Notification Permission
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        //hear we make the request apple watch data code
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            print("session OK")
        } else {
            print("error, session is not suported")
        }
        
        return true
    }

    
    private func setAppearance() {
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
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