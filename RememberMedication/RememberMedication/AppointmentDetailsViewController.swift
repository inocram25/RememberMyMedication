//
//  AppointmentDetailViewController.swift
//  RememberMedication
//
//  Created by guilherme babugia on 09/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class AppointmentDetailsViewController: UITableViewController {
    
    var appointment: Appointment?
    
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var dayLabel: UILabel?
    @IBOutlet private weak var monthLabel: UILabel?
    @IBOutlet private weak var timeLabel: UILabel?
    @IBOutlet private weak var doctorLabel: UILabel?
    @IBOutlet private weak var localLabel: UILabel?
    @IBOutlet private weak var notesLabel: UILabel?
    @IBOutlet private weak var borderedView: BorderedView?
    
    @IBOutlet private weak var notesCell: UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let appointment = appointment {
            nameLabel?.text = appointment.name
            doctorLabel?.text = appointment.doctor
            localLabel?.text = appointment.local
            notesLabel?.text = appointment.notes
            dayLabel?.text = "\(appointment.date.day)"
            timeLabel?.text = "\(appointment.date.hour):\(appointment.date.minute)"
            monthLabel?.text = appointment.date.month?.description
            borderedView?.backgroundColor = appointment.date.month?.color
        }
        
        tableView.reloadData()
        tableView.allowsSelection = false
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15.0
    }
}
