//
//  ViewController.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 4/28/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class AppointmentsViewController: UIViewController {
    
    @IBOutlet weak var appointmentsTableView: UITableView!
    
    var appointments = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentsTableView.backgroundColor = UIColor.healthU_LightGrey()

        loadAppointments()
        appointmentsTableView.tableFooterView = UIView()
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
            let appointment = Appointment(name: appoint.name, date: appoint.date, doctor: appoint.doctor,
                                          local: appoint.local, notes: appoint.notes)
            appointments.append(appointment)
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AppointmentDetail" {
            let vc = segue.destinationViewController as! AppointmentDetailsViewController
            let cell = sender as? AppointmentsTableViewCell
            vc.appointment = cell?.currentAppointment
        }
    }
    
    @IBAction func unwindSegueToAppointmentViewController(segue: UIStoryboardSegue) {
    }
}

extension AppointmentsViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            AppointmentServices.deleteByDate(appointments[indexPath.row].date)
            appointments.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? AppointmentsTableViewCell
        performSegueWithIdentifier("AppointmentDetail", sender: cell)
    }
    
}