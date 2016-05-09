//
//  AppointmentDetailViewController.swift
//  RememberMedication
//
//  Created by guilherme babugia on 09/05/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class AppointmentDetailViewController: UIViewController {
    
    
    var date = NSDate()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let appointment = AppointmentDAO.findByDate(date)
        
        print(appointment!.name)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
