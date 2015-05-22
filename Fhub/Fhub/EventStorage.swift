//
//  EventStorage.swift
//  Fhub
//
//  Created by Francisco Ferreira on 5/18/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation

class EventStorage {
    
    // MARK: Event
    static func getAll(handler: ParseHandler){
        let eQry: PFQuery = Event.query()!

        handler.onStart()
        eQry.findObjectsInBackgroundWithBlock { (res: [AnyObject]?, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: res as! [Event]))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    static func add(name: NSString, information: NSString, datetime: NSDate, address: NSString, address_geo: PFGeoPoint, price: NSNumber, photo_profile: PFFile, photo_cover: PFFile, handler: ParseHandler){
        var nEve: Event = Event()
        nEve.name = name
        nEve.information = information
        nEve.datetime = datetime
        nEve.address = address
        nEve.address_geo = address_geo
        nEve.price = price
        nEve.photo_profile = photo_profile
        nEve.photo_cover = photo_cover
        nEve.createdBy = User.currentUser()
        
        handler.onStart()
        nEve.saveInBackgroundWithBlock { (suc: Bool, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: suc as Bool))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    static func update(event: Event, handler: ParseHandler){
        handler.onStart()
        event.saveInBackgroundWithBlock { (suc: Bool, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: suc as Bool))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    static func remove(event: Event, handler: ParseHandler){
        handler.onStart()
        event.deleteInBackgroundWithBlock { (suc: Bool, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: suc as Bool))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    
    // MARK: Event Photos
    static func getAllPhotos(event: Event, handler: ParseHandler){
        let tQry: PFQuery = EventPhoto.query()!
        tQry.whereKey("belongsTo", equalTo: event.objectId!)
        
        handler.onStart()
        tQry.findObjectsInBackgroundWithBlock { (res: [AnyObject]?, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: res as! [EventPhoto]))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    static func addPhoto(photo: PFFile, name: NSString, event: Event, handler: ParseHandler){
        var nPhoto: EventPhoto = EventPhoto()
        nPhoto.photo = photo
        nPhoto.name = name
        nPhoto.belongsTo = event
        
        handler.onStart()
        nPhoto.saveInBackgroundWithBlock { (suc: Bool, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: suc as Bool))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    static func removePhoto(photo: EventPhoto, handler: ParseHandler){
        handler.onStart()
        photo.deleteInBackgroundWithBlock { (suc: Bool, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: suc as Bool))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    
    // MARK: Event Posts
    static func getAllPosts(event: Event, handler: ParseHandler){
        let tQry: PFQuery = EventPost.query()!
        tQry.whereKey("belongsTo", equalTo: event.objectId!)
        
        handler.onStart()
        tQry.findObjectsInBackgroundWithBlock { (res: [AnyObject]?, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: res as! [EventPost]))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    static func addPost(post: NSString, event: Event, handler: ParseHandler){
        var nPost: EventPost = EventPost()
        nPost.information = post
        nPost.belongsTo = event
        nPost.createdBy = User.currentUser()
        nPost.datetime = NSDate()
        
        handler.onStart()
        nPost.saveInBackgroundWithBlock { (suc: Bool, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: suc as Bool))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    static func removePost(post: EventPost, handler: ParseHandler){
        handler.onStart()
        post.deleteInBackgroundWithBlock { (suc: Bool, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: suc as Bool))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    
    // MARK: Event Participants
    static func getAllParticipants(event: Event, handler: ParseHandler){
        let tQry: PFQuery = EventParticipant.query()!
        tQry.whereKey("belongsTo", equalTo: event.objectId!)
        
        handler.onStart()
        tQry.findObjectsInBackgroundWithBlock { (res: [AnyObject]?, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: res as! [EventParticipant]))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    static func addParticiapant(event: Event, participant: User, handler: ParseHandler){
        var nParticipant: EventParticipant = EventParticipant()
        nParticipant.belongsTo = event
        nParticipant.participantIS = participant
        
        handler.onStart()
        nParticipant.saveInBackgroundWithBlock { (suc: Bool, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: suc as Bool))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
    static func removeParticipant(participant: EventParticipant, handler: ParseHandler){
        handler.onStart()
        participant.deleteInBackgroundWithBlock { (suc: Bool, err: NSError?) -> Void in
            if err == nil {
                handler.onSuccess(ParseResult(dataSuccess: suc as Bool))
            }
            else {
                handler.onError(ParseResult(dataError: err!))
            }
            handler.onFinish()
        }
    }
}