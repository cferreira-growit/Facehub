//
//  LBFunctions.swift
//  LifeBaby
//
//  Created by Francisco Ferreira on 4/9/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import UIKit

class Functions: NSObject {
 
    func displaySimpleAlertWithTitle(title: NSString, message: NSString, view: UIViewController){
        let alertController: UIAlertController = UIAlertController(
            title: title as String,
            message: message as String,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        view.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func getDelayTimeInSeconds(seconds: Double) -> dispatch_time_t{
        return dispatch_time(DISPATCH_TIME_NOW,Int64( seconds * Double(NSEC_PER_SEC)))
    }
}