//
//  AppViewController.swift
//  FranciscoFerreira
//
//  Created by Francisco Ferreira on 4/15/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Class Functions
    func setNavigationDefaultColors(bar:UINavigationBar!){
        self.setNavigationDefaultColorsWithTitleColor(UIColor.whiteColor(), bar: bar)
    }
    
    func setNavigationDefaultColorsWithTitleColor(titleColor: UIColor, bar:UINavigationBar!){
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        bar.tintColor = UIColor.whiteColor()
        bar.titleTextAttributes = [NSForegroundColorAttributeName:titleColor]
    }
    
    func clearCurrEvent(){
        AppCore.ref.currEvent = nil
    }
}