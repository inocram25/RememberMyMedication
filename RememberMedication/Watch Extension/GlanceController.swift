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


class GlanceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var nameOutlet: WKInterfaceLabel!
    @IBOutlet var dateOutlet: WKInterfaceLabel!
    @IBOutlet var patientNameOutlet: WKInterfaceLabel!
    @IBOutlet var dosageOutlet: WKInterfaceLabel!
    
    var messageDictionary = ["messageType": "getLastDate" , "name": "", "date": "", "patientName": "", "dosage": ""]

    
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
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.isSupported()
        {
            session = WCSession.defaultSession()
            
            session!.sendMessage(messageDictionary, replyHandler: { (response:[String : AnyObject]) -> Void in
                
                let name = response["name"] as? String
                let endDate = response["date"] as? String
                let patientName = response["patientName"] as? String
                let dosage = response["dosage"] as? String
                print(response)
                self.nameOutlet.setText(name)
                self.dateOutlet.setText(endDate)
                self.patientNameOutlet.setText(patientName)
                self.dosageOutlet.setText(dosage)
                
                }, errorHandler: { (error) -> Void in
                    
                    print(#function,error)
            })
            
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
