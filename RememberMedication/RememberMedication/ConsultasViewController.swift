//
//  ViewController.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 4/28/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class ConsultasViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let d = NSDate(timeIntervalSinceNow: 10)
        let a = NSDate(timeIntervalSinceNow: 15)
        scheduleLocal(d)
        scheduleLocal(a)
    }
    
    func scheduleLocal(date: NSDate) {
        let notification = UILocalNotification()
        notification.fireDate = date
        notification.alertBody = "Hey you! Yeah you! Swipe to unlock!"
        notification.alertAction = "be awesome!"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}

