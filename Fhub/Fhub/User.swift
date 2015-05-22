//
//  User.swift
//  Fhub
//
//  Created by Francisco Ferreira on 5/18/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation
import Parse

class User : PFUser, PFSubclassing{
    
    override class func initialize() {
        struct Static { static var onceToken : dispatch_once_t = 0; }
        dispatch_once(&Static.onceToken) { self.registerSubclass() }
    }
    
    override class func currentUser() -> User? {
        return (PFUser.currentUser() as? User)!
    }
    
    @NSManaged var facebookID: NSString!
    @NSManaged var first_name: NSString!
    @NSManaged var last_name: NSString!
    @NSManaged var photo: PFFile!
    
    
    var loadePhoto: UIImage!
}