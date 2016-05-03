//
//  AddMedicineTableViewController.swift
//  RememberMedication
//
//  Created by Leonardo Maffei on 03/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class AddMedicineTableViewController: UITableViewController {
    
    var pickerVisible = false
    
    @IBOutlet weak var toggle: UISwitch!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        
    }
    
    @IBAction func switchAction(sender: AnyObject) {
        tableView.reloadData()
    }
    
    @IBAction func pickerTest(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        // date.text = dateFormatter.stringFromDate(sender.date)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            pickerVisible = !pickerVisible
            tableView.reloadData()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 2 {
            if toggle.on == false || pickerVisible == false {
                return 0.0
            }
            return 165.0
        }
        return 44.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44.0
    }
    
}
