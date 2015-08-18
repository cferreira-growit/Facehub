//
//  UserStorage.swift
//  Fhub
//
//  Created by Francisco Ferreira on 5/18/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation

class UserStorage {
    
    static func getAll(handler: ParseHandler){
        var tQry: PFQuery = User.query()!
        
        handler.onStart()
        tQry.findObjectsInBackgroundWithBlock { (res: [AnyObject]?, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: res as! [User]))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    
    static func signInWithUsername(username: NSString, password: NSString, handler: ParseHandler){
        handler.onStart()
        User.logInWithUsernameInBackground(username as! String, password: password as! String) { (user: PFUser?, error: NSError?) -> Void in
            if error == nil {
                handler.onSuccess(ParseResult(dataSuccess: user as! User))
            }
            else {
                handler.onError(ParseResult(dataError: error!))
            }
            handler.onFinish()
        }
    }
    
    static func signUpWithUsername(username: NSString, password: NSString, email: NSString, handler: ParseHandler){
        var nUser: User = User()
        nUser.username = username as String
        nUser.password = password as String
        nUser.email = email as String
        
        handler.onStart()
        nUser.signUpInBackgroundWithBlock({ (succeeded: Bool,  error: NSError?) -> Void in
            if error == nil {
                handler.onSuccess(ParseResult(dataSuccess: succeeded as Bool))
            }
            else {
                handler.onError(ParseResult(dataError: error!))
            }
            handler.onFinish()
        })
    }
    
    static func getMyEvents(orderByDate: Bool = false, handler: ParseHandler){
        var eQry = EventParticipant.query()!
        
        eQry.includeKey("belongsTo")
        eQry.whereKey("participantIS", equalTo: User.currentUser())
        
        if orderByDate {
            eQry.orderByAscending("datetime")
        }
        
        handler.onStart()
        eQry.findObjectsInBackgroundWithBlock { (res: [AnyObject]?, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: res as! [EventParticipant]))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
}