//
//  LBFunctions.swift
//  LifeBaby
//
//  Created by Francisco Ferreira on 4/9/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import UIKit

class Functions: NSObject {
 
    static func displaySingleButtonAlertWithTitle(title: NSString, message: NSString, view: UIViewController, buttonTitle: NSString = "Dismiss", buttonBlock: () -> () = {} ){
        let alertController: UIAlertController = UIAlertController(
            title: title as String,
            message: message as String,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        alertController.addAction(UIAlertAction(title: buttonTitle as String, style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            buttonBlock()
        }))
        view.presentViewController(alertController, animated: true, completion: nil)
    }
    
    static func displayTwoButtonAlertWithTitle(title: NSString, message: NSString, view: UIViewController, buttonOneTitle: NSString = "Dismiss", buttonOneBlock: () -> () = {}, buttonTwoTitle: NSString = "Dismiss", buttonTwoBlock: () -> () = {} ){
        let alertController: UIAlertController = UIAlertController(
            title: title as String,
            message: message as String,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        alertController.addAction(UIAlertAction(title: buttonOneTitle as String, style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            buttonOneBlock()
        }))
        alertController.addAction(UIAlertAction(title: buttonTwoTitle as String, style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            buttonTwoBlock()
        }))
        view.presentViewController(alertController, animated: true, completion: nil)
        
    }


    
    static func getDelayTimeInSeconds(seconds: Double) -> dispatch_time_t{
        return dispatch_time(DISPATCH_TIME_NOW,Int64( seconds * Double(NSEC_PER_SEC)))
    }
}