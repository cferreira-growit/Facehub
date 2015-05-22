//
//  AppCore.swift
//  LifeBaby
//
//  Created by Francisco Ferreira on 4/11/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import UIKit

class AppCore: NSObject {
    
    var currEvent: Event?
    
    class var ref: AppCore {
        struct Static {
            static var instance: AppCore?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = AppCore()
        }
        
        return Static.instance!
    }
}