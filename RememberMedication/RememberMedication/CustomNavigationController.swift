//
//  NBBNavigationController.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 4/29/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//
import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldAutorotate() -> Bool {
        return topViewController?.shouldAutorotate() ?? true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations() ?? .Portrait
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle() ?? .Default
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return topViewController?.prefersStatusBarHidden() ?? false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}


