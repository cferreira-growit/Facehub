//
//  UserDefaultsAccess.swift
//  LifeBaby
//
//  Created by Francisco Ferreira on 4/10/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import UIKit
import CoreData

enum AppDefaultsKeys : NSString{
    case Key = "key"
}

class AppUserDefaults: NSObject {
    
    private let access = NSUserDefaults.standardUserDefaults()
}