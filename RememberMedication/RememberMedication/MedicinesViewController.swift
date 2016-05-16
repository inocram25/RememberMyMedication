//
//  ViewController.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 4/28/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class MedicinesViewController: UIViewController {

    @IBOutlet weak var medicinesTableView: UITableView!
    
    private var medicines = [Medication]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMedicines()
        let notification = NotificationScheduler()
        notification.scheduleNotificationWithMedications(medicines)
    
        medicinesTableView.emptyDataSetSource = self
        medicinesTableView.emptyDataSetDelegate = self
        medicinesTableView.backgroundColor = UIColor.healthU_LightGrey()
        medicinesTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadMedicines()
        medicinesTableView.reloadData()
    }
    
    func loadMedicines() {
        let medicationCD = MedicationDAO.returnAll()! as [MedicationCD]
        medicines.removeAll()
        for m in medicationCD {
            let medication = Medication(name: m.name, dosage: m.dosage,
                                        patient: m.patient, interval: m.interval,
                                        startDate: m.startDate, endDate: m.endDate,
                                        weekDay: m.weekDay, id: m.id, red: m.red,
                                        green: m.green, blue: m.blue)
            
            medicines.append(medication)
        }
    }

    //Navigation
    @IBAction func unwindSegueToMedicinesViewController(segue: UIStoryboardSegue) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MedicineDetail" {
            let vc = segue.destinationViewController as! MedicinesDetailsViewController
            let cell = sender as? MedicinesTableViewCell
            vc.medication = cell?.currentMedication
        }
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
        cell?.selectionStyle = .None
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            print(medicines[indexPath.row])
            MedicationServices.deleteByName(medicines[indexPath.row].name)
            medicines.removeAtIndex(indexPath.row)
            
            NotificationScheduler().scheduleNotificationWithMedications(medicines)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? MedicinesTableViewCell
        performSegueWithIdentifier("MedicineDetail", sender: cell)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

    }
}

extension MedicinesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = NSLineBreakMode.ByWordWrapping
        paragraph.alignment = NSTextAlignment.Center
        
        let font = UIFont.boldSystemFontOfSize(18.0)
        
        let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.darkGrayColor(), NSParagraphStyleAttributeName: paragraph]
        
        return NSAttributedString(string: "Nenhum medicamento adicionado", attributes: attributes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = NSLineBreakMode.ByWordWrapping
        paragraph.alignment = NSTextAlignment.Center
        
        let font = UIFont.systemFontOfSize(18.0)
        
        let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.healthU_Orange(), NSParagraphStyleAttributeName: paragraph]
        
        return NSAttributedString(string: "Clique no ＋ para adicionar um medicamento", attributes: attributes)
    }

    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "tutorial")
    }
    
    
    func spaceHeightForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        return 20.0
    }
}
