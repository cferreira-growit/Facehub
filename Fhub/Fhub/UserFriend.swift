//
//  User_Friends.swift
//  Fhub
//
//  Created by Francisco Ferreira on 5/18/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation

class UserFriend : PFObject, PFSubclassing {
    
    override class func initialize() {
        struct Static { static var onceToken : dispatch_once_t = 0; }
        dispatch_once(&Static.onceToken) { self.registerSubclass() }
    }
    override init(){ super.init() }
    
    static func parseClassName() -> String { return "User_Friends" }
    
    @NSManaged var belongsTo: User!
    @NSManaged var friendIS: User!
}