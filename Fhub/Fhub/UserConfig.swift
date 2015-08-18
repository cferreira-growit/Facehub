//
//  User_Configs.swift
//  Fhub
//
//  Created by Francisco Ferreira on 5/18/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation

class UserConfig : PFObject, PFSubclassing {
    
    override class func initialize() {
        struct Static { static var onceToken : dispatch_once_t = 0; }
        dispatch_once(&Static.onceToken) { self.registerSubclass() }
    }
    override init(){ super.init() }
    
    static func parseClassName() -> String { return "User_Configs" }
 
    @NSManaged var belongsTo: User!
    @NSManaged var private_acc: NSNumber!
    @NSManaged var block_push_questions: NSNumber!
    @NSManaged var block_push_notification: NSNumber!
    @NSManaged var block_push_info: NSNumber!
    @NSManaged var cellular_full_quality: NSNumber!
}