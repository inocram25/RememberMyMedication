//
//  NotificationController.swift
//  Watch Extension
//
//  Created by Alexandre Calil Marconi on 4/28/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {

    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        print("will")
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        print("did")
        super.didDeactivate()
    }

    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a local notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        print("recieve")
        completionHandler(.Custom)
    }
 
    /*
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a remote notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        completionHandler(.Custom)
    }
    */
}