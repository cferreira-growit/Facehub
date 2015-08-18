//
//  Event_Posts.swift
//  Fhub
//
//  Created by Francisco Ferreira on 5/18/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation

class EventPost : PFObject, PFSubclassing {
    
    override class func initialize() {
        struct Static { static var onceToken : dispatch_once_t = 0; }
        dispatch_once(&Static.onceToken) { self.registerSubclass() }
    }
    override init(){ super.init() }
    
    static func parseClassName() -> String { return "Event_Posts" }
 
    @NSManaged var belongsTo: Event!
    @NSManaged var createdBy: User!
    @NSManaged var information: NSString!
    @NSManaged var datetime: NSDate!
}