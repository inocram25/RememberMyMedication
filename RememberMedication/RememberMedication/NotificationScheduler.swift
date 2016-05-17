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
    
    var meds = [Medication]()
    let limitNotification = 64
    
    func scheduleNotificationWithMedications(medications: [Medication]) {
        meds.removeAll()
        let notifications =  createNotificationsWithMedications(medications)
        scheduleNotification(notifications)
        
    }
    
    func createNotificationsWithMedications(medications: [Medication]) -> [UILocalNotification] {
        for medication in medications {
            createDatesWithMedication(medication)
        }
        
        let orderDates = meds.sort { $0.startDate.compare($1.startDate) == .OrderedAscending }
        let result = orderDates[0..<min(limitNotification, orderDates.count)]
        
        if !result.isEmpty {
            let userDefault =  NSUserDefaults(suiteName: "medicines")
            userDefault?.setValue(result[0].name, forKey: "medicineName")
            userDefault?.synchronize()
        }
        
        var notifications = [UILocalNotification]()
        for med in result {
            notifications.append(createNotificationWithDate(med))
//            print("Nome = \(med.name)    ----- Data = \(med.startDate)")
        }
        
        return notifications
    }
    
    func createDatesWithMedication(medication: Medication) {
        var date = medication.startDate
        if medication.startDate.isGreaterThanDate(NSDate()) {
            meds.append(medication)
        }
        
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
            if medication.weekDay.contains(WeekDay(rawValue: Int16(newDate.dayOfWeek!))) {
                if newDate.isGreaterThanDate(NSDate()) {
                    let m = Medication(name: medication.name, dosage: medication.dosage,
                                       patient: medication.patient, interval: medication.interval,
                                       startDate: newDate, endDate: medication.endDate,
                                       weekDay: medication.weekDay, id: medication.id,
                                       red: medication.red, green: medication.green,
                                       blue: medication.blue)
                    meds.append(m)
                }
            }
            date = newDate
        }
        
    }
    
    func scheduleNotification(notifications: [UILocalNotification]) {
        //VAI PERDER TODOS ALARMS DAS CONSULTAS (?)
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        for notification in notifications {
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    func createNotificationWithDate (medication: Medication) -> UILocalNotification {
        let notification = UILocalNotification()
        notification.fireDate = medication.startDate
        notification.alertBody = "Hora de tomar \(medication.name)"
        notification.alertAction = "Ver"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.category = "myCategory"
        notification.userInfo = ["name" : medication.name,
                                 "dosage" : medication.dosage,
                                 "patient" : medication.patient]
        return notification
    }
    
}
