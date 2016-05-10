//
//  NotificationScheduler.swift
//  RememberMedication
//
//  Created by guilherme babugia on 10/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import Foundation
import UIKit

class NotificationScheduler {
    
    var dates = [NSDate]()
    let limitNotification = 64
    
    func scheduleNotificationWithMedications(medications: [Medication]) {
        
        let notifications =  createNotificationsWithMedications(medications)
        scheduleNotification(notifications)
        
    }
    
    func createNotificationsWithMedications(medications: [Medication]) -> [UILocalNotification] {
        for medication in medications {
            let datesMedication = createDatesWithMedication(medication)
            dates.appendContentsOf(datesMedication)
        }
        let orderDates = dates.sort { $0.compare($1) == .OrderedAscending }
        let result = orderDates[0..<min(limitNotification, orderDates.count)]
        
        
        var notifications = [UILocalNotification]()
        for date in result {
            notifications.append(createNotificationWithDate(date))
        }
        
        
        return notifications
    }
    
    func createDatesWithMedication(medication: Medication) -> [NSDate] {
        //medication.weekDay.contains(WeekDay.Sunday)
        
        return [NSDate]()
    }
    
    func scheduleNotification(notifications: [UILocalNotification]) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        for notification in notifications {
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    func createNotificationWithDate (date: NSDate) -> UILocalNotification {
        let notification = UILocalNotification()
        notification.fireDate = date
        notification.alertBody = "Hora de tomar remedio!"
        notification.alertAction = "be awesome!"
        notification.soundName = UILocalNotificationDefaultSoundName
        return notification
    }
}