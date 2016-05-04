//
//  ViewController.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 4/28/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class MedicinesViewController: UIViewController {

    @IBOutlet weak var medicinesTableView: UITableView!
    
    var medicines = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMedicines()
        medicinesTableView.tableFooterView = UIView()
        scheduleLocal(NSDate(timeIntervalSinceNow: 10))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadMedicines()
        medicinesTableView.reloadData()
    }
    
    func loadMedicines() {
        let data = MedicationDAO.returnAll()! as [MedicationCD]
        medicines.removeAll()
        for meds in data {
            medicines.append(meds.name)
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

    @IBAction func unwindSegueToMedicinesViewController(segue: UIStoryboardSegue) {
    }
}

extension MedicinesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("medicinesCell") as? MedicinesTableViewCell
        cell?.configureCell(medicines[indexPath.row])
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            MedicationServices.deleteByName(medicines[indexPath.row])
            medicines.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
}
