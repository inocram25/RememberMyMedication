//
//  InterfaceController.swift
//  VimoHeartRate WatchKit App Extension
//
//  Created by Ethan Fan on 6/25/15.
//  Copyright © 2015 Vimo Lab. All rights reserved.
//

import Foundation
import WatchConnectivity
import WatchKit


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var tableView: WKInterfaceTable!
    
    var medicines = [MedicineWatch]()
    var messageDictionary = ["messageType": "medicine"]
    
    func setupTable() {
        tableView.setNumberOfRows(medicines.count, withRowType: "medicineRow")
        
        print("rows = \(tableView.numberOfRows)")
        
        for i in 0 ..< medicines.count {
            if let row = tableView.rowControllerAtIndex(i) as? MedicineRow {
                row.nameLabel.setText(medicines[i].name)
                row.timeLabel.setText(medicines[i].date)
                row.patientLabel.setText(medicines[i].patient)
            }
        }
    }
    
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            
        }
        
    }
    
    override func willActivate() {
        super.willActivate()
        
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            
            session!.sendMessage(messageDictionary, replyHandler: { response in
                print("response = \(response)")
                let meds = response["medicines"] as? [[String : String]]
                
                for m in meds! {
                    let medicine = MedicineWatch(name: m["name"]!, dosage: m["dosage"]!, date: m["date"]!, patient: m["patient"]!)
                    self.medicines.append(medicine)
                }
                
                self.setupTable()

                }, errorHandler: { error in
                    print(#function,error)
            })
        }
        
            }
}
