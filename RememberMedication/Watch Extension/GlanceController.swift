//
//  GlanceController.swift
//  Watch Extension
//
//  Created by Alexandre Calil Marconi on 4/28/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

struct MedicineWatch {
    let name: String
    let dosage: String
    let date: String
}


class GlanceController: WKInterfaceController, WCSessionDelegate {


    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var timeLabel: WKInterfaceLabel!
    @IBOutlet var patientLabel: WKInterfaceLabel!
    
    var medicines = [MedicineWatch]()
    var messageDictionary = ["messageType": "medicine"]

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
    }

    override func willActivate() {
        super.willActivate()
        
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            
            session!.sendMessage(messageDictionary, replyHandler: { response in
                print("response = \(response)")
                let meds = response["medicines"] as? [[String : String]]
                
                for m in meds! {
                    let medicine = MedicineWatch(name: m["name"]!, dosage: m["dosage"]!, date: m["data"]!)
                    self.medicines.append(medicine)
                }
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
                dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
                let date = dateFormatter.dateFromString(self.medicines[0].date)
                
                let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: date!)
                let minute = NSCalendar.currentCalendar().component(.Minute, fromDate: date!)
                
                self.nameLabel.setText(self.medicines[0].name)
                self.timeLabel.setText("\(hour):\(minute)")
                self.patientLabel.setText("toninho")
                
                }, errorHandler: { error in
                    print(#function,error)
            })
        }
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
