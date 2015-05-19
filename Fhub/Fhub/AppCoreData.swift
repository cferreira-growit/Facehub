//
//  CoreDataAccess.swift
//  LifeBaby
//
//  Created by Francisco Ferreira on 4/9/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import UIKit
import CoreData

class AppCoreData{
    
    private let access: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate!).managedObjectContext!
    
    func RequestWithEntityName(entityName: String, predicate: NSPredicate!) -> (results: NSArray, error: NSError?) {
        return self.RequestWithEntityName(entityName, predicate: predicate, sort: nil)
    }
    
    func RequestWithEntityName(entityName: String, predicate: NSPredicate!, sort: NSSortDescriptor!) -> (results: NSArray, error: NSError?) {
        var error: NSError?
        let fetch: NSFetchRequest = NSFetchRequest(entityName: entityName)
        
        if sort != nil {
            fetch.sortDescriptors = [sort]
        }

        fetch.predicate = predicate
        
        let results: NSArray! = self.access.executeFetchRequest(fetch, error: &error)
        
        return (results, error)
    }
    
    func GetEntityWithName(entityName: NSString) -> AnyObject{
        return NSEntityDescription.insertNewObjectForEntityForName(entityName as String, inManagedObjectContext: self.access)
    }
    
    func InsertEntityWithObject(object: NSManagedObject) -> NSError? {
        var error: NSError?
        self.access.save(&error)
        
        return error
    }
    
    func SaveEntityWithObject(object: NSManagedObject) -> NSError? {
        return self.InsertEntityWithObject(object) as NSError?
    }
    
    func GetAccess()->NSManagedObjectContext{
        return self.access
    }
}