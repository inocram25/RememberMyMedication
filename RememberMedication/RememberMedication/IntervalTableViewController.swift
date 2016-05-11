//
//  IntervalTableViewController.swift
//  RememberMedication
//
//  Created by guilherme babugia on 11/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class IntervalTableViewController: UITableViewController {

    var selectedInterval = 0
    private let interval = [1, 2, 3, 4, 6, 8, 12]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        print(selectedInterval)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        selectedInterval = interval[indexPath.row]
        performSegueWithIdentifier("IntervalSelected", sender: self)
    }
    
}
