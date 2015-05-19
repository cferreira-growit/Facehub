//
//  Events.swift
//  Fhub
//
//  Created by Francisco Ferreira on 5/18/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation

class Event : PFObject, PFSubclassing {
    
    override class func initialize() {
        struct Static { static var onceToken : dispatch_once_t = 0; }
        dispatch_once(&Static.onceToken) { self.registerSubclass() }
    }
    override init(){ super.init() }
    
    static func parseClassName() -> String { return "Events" }
    
    @NSManaged var createdBy: User!
    @NSManaged var eventFacebookID: NSString!
    @NSManaged var name: NSString!
    @NSManaged var information: NSString!
    @NSManaged var age_restriction: NSNumber!
    @NSManaged var phone_contact: NSString!
    @NSManaged var email_contact: NSString!
    @NSManaged var website: NSString!
    @NSManaged var facebook: NSString!
    @NSManaged var twitter: NSString!
    @NSManaged var instagram: NSString!
    @NSManaged var datetime: NSDate!
    @NSManaged var address: NSString!
    @NSManaged var address_geo: PFGeoPoint!
    @NSManaged var price: NSNumber!
    @NSManaged var tickets_remain: NSNumber!
    @NSManaged var photo_profile: PFFile!
    @NSManaged var photo_cover: PFFile!
    @NSManaged var photo_background: PFFile!
}