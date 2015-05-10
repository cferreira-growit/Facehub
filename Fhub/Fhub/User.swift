//
//  User.swift
//  Fhub
//
//  Created by Guilherme Moresco Bisotto on 4/27/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation
import CoreData

@objc(User)

class User: NSManagedObject {

    @NSManaged var userID: String
    @NSManaged var username: String
    @NSManaged var password: String
    @NSManaged var userEmail: String
    @NSManaged var facebookID: String
    @NSManaged var userFirstName: String
    @NSManaged var userLastName: String
    @NSManaged var userPhoto: NSDate

}
