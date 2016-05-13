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
                    let medicine = MedicineWatch(name: m["name"]!, dosage: m["dosage"]!, date: m["data"]!)
                    self.medicines.append(medicine)
                }
                
                
                }, errorHandler: { error in
                    print(#function,error)
            })
        }

    }
}
