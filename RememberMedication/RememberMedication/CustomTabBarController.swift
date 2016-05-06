//
//  CustomTabBarController.swift
//  RememberMedication
//
//  Created by Alexandre Calil Marconi on 4/29/16.
//  Copyright © 2016 Alexandre Calil Marconi. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in tabBar.items! as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(UIColor.lightGrayColor()).imageWithRenderingMode(.AlwaysOriginal)
            }
            
            if let selectedImage = item.selectedImage {
                item.selectedImage = selectedImage.imageWithColor(UIColor.healthU_Orange())
                    .imageWithRenderingMode(.AlwaysOriginal)
            }
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return selectedViewController?.shouldAutorotate() ?? true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return selectedViewController?.supportedInterfaceOrientations() ?? .Portrait
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return selectedViewController?.preferredStatusBarStyle() ?? .Default
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return selectedViewController?.prefersStatusBarHidden() ?? false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

