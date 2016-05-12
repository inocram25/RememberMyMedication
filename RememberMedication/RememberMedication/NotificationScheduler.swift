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
        dates.removeAll()
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
        var date = medication.startDate
        dates.append(date)
        print(medication.weekDay.contains(WeekDay.Thursday))
        
        let components = NSDateComponents()
        if medication.interval == 0 {
            components.hour = 24
        }else{
            components.hour = Int(medication.interval)
        }
        
        while(true){
            let newDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: date, options: NSCalendarOptions.init(rawValue: 0))!
            if newDate.isGreaterThanDate(medication.endDate){
                break;
            }
            if medication.weekDay.contains(WeekDay(rawValue: Int16(newDate.dayOfWeek()!))) {
                dates.append(newDate)
            }
            date = newDate
        }
        
        for i in dates {
            print(i)
        }
        
        return dates
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

extension NSDate {
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func dayOfWeek() -> Int? {
        if
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Weekday, fromDate: self) {
            return  1 << (comp.weekday - 1)
        } else {
            return nil
        }
    }
}