//
//  AppointmentDetailViewController.swift
//  RememberMedication
//
//  Created by guilherme babugia on 09/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

private enum AppointmentDetailTable: String {
    case Name = "0,0"
    case Time = "1,0"
    case Doctor = "1,1"
    case Local = "1,2"
    case Notes = "2,0"
    
    init?(indexPath: NSIndexPath) {
        let toString = "\(indexPath.section),\(indexPath.row)"
        if let option = AppointmentDetailTable(rawValue: toString) {
            self = option
        } else {
            return nil
        }
    }
}

extension NSIndexPath {
    private var option: AppointmentDetailTable? {
        return AppointmentDetailTable(indexPath: self)
    }
}

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
    @IBOutlet var backViews: [UIView]!
    
    @IBOutlet private weak var notesCell: UITableViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let appointment = appointment {
            nameLabel?.text = appointment.name
            doctorLabel?.text = "Médico: \(appointment.doctor)"
            localLabel?.text = "Local: \(appointment.local)"
            notesLabel?.text = appointment.notes
            dayLabel?.text = "\(appointment.date.day)"
            timeLabel?.text = "Horário: \(appointment.date.hour):\(appointment.date.minute)"
            monthLabel?.text = appointment.date.month?.description
            borderedView?.backgroundColor = appointment.date.month?.color
        }
        
        backViews?.forEach { view in
            let layer = view.layer
            layer.shadowColor = UIColor.blackColor().CGColor
            layer.shadowOffset = CGSize(width: 0, height: 0.5)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = 1
        }
        
        tableView.reloadData()
        tableView.allowsSelection = false
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.option == .Name {
            return UITableViewAutomaticDimension
        }
        if indexPath.option == .Time {
            return 60.0
        }
        if indexPath.option == .Doctor && appointment?.doctor.isEmpty == false {
            return 60.0
        }
        
        if indexPath.option == .Local && appointment?.local.isEmpty == false {
            return 60.0
        }
        
        if indexPath.option == .Notes  && appointment?.notes.isEmpty == false {
            return UITableViewAutomaticDimension
        }
        
        return 0.0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15.0
    }
}
