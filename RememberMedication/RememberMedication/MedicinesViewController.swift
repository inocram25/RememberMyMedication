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
        
        let d = NSDate(timeIntervalSinceNow: 10)
        let a = NSDate(timeIntervalSinceNow: 15)
        scheduleLocal(d)
        scheduleLocal(a)
        
        medicines.append("gardenal")
        medicines.append("viagra")
        medicines.append("prosac")
        medicines.append("boa noite cinderela")

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
    @IBAction func addMedicineButton(sender: AnyObject) {
        medicines.append("remedio")
        medicinesTableView.reloadData()
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
    
}
