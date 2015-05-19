//
//  Event_Participants.swift
//  Fhub
//
//  Created by Francisco Ferreira on 5/18/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation

class EventParticipant : PFObject, PFSubclassing {
    
    override class func initialize() {
        struct Static { static var onceToken : dispatch_once_t = 0; }
        dispatch_once(&Static.onceToken) { self.registerSubclass() }
    }
    override init(){ super.init() }
    
    static func parseClassName() -> String { return "Event_Participants" }
 
    @NSManaged var belongsTo: Event!
    @NSManaged var participantIS: User!
    @NSManaged var status: NSNumber!
    @NSManaged var display_rg: NSNumber!
    @NSManaged var display_cpf: NSNumber!
    @NSManaged var display_home: NSNumber!
    @NSManaged var display_profile: NSNumber!
    @NSManaged var car_available: NSNumber!
}