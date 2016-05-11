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
    @IBOutlet var dateOutlet: WKInterfaceDate!
    @IBOutlet var patientNameOutlet: WKInterfaceLabel!
    
    var messageDictionary = ["messageType": "getLastDate" , "name": "", "date": ""]

    
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
                
                print(response)
                
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
