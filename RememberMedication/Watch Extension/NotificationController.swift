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
    
    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var dosageLabel: WKInterfaceLabel!

    override init() {
        super.init()
    }

    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        print("recieve")
        if let name = localNotification.userInfo?["name"] as? String {
            nameLabel.setText(name)
        }
        if let dosage = localNotification.userInfo?["dosage"] as? String {
            dosageLabel.setText("\(dosage)mg")

        }
        if let patient = localNotification.userInfo?["patient"] as? String {
            
        }
        
        completionHandler(.Custom)
    }
 
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        print("remote")
        completionHandler(.Custom)
    }
}
