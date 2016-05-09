//
//  ViewController.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 4/28/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class ConsultasViewController: UIViewController {
    
    @IBOutlet weak var appointmentsTableView: UITableView!
    
    var appointments = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let d = NSDate(timeIntervalSinceNow: 10)
        let a = NSDate(timeIntervalSinceNow: 15)
        scheduleLocal(d)
        scheduleLocal(a)
        
        loadAppointments()
        appointmentsTableView.tableFooterView = UIView()
        scheduleLocal(NSDate(timeIntervalSinceNow: 10))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadAppointments()
        appointmentsTableView.reloadData()
    }
    
    func loadAppointments() {
        let data = AppointmentDAO.returnAll()! as [AppointmentCD]
        appointments.removeAll()
        for appoint in data {
            let appointment = Appointment(name: appoint.name, date: appoint.date,
                                          alarmDate: appoint.alarmDate, doctor: appoint.doctor,
                                          local: appoint.local, notes: appoint.notes)
            appointments.append(appointment)
        }

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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AppointmentDetail" {
            let vc = segue.destinationViewController as! AppointmentDetailViewController
            vc.date = (sender as! NSDate)
        }
    }
}

extension ConsultasViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("appointmentCell") as? AppointmentsTableViewCell
        
        cell?.configureCell(appointments[indexPath.row])
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            print(appointments[indexPath.row])
            AppointmentServices.deleteByDate(appointments[indexPath.row].date)
            appointments.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("AppointmentDetail", sender: appointments[indexPath.row].date)
    }
    
}