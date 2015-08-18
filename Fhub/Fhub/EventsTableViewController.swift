//
//  EventsTableViewControler.swift
//  Fhub
//
//  Created by Guilherme Moresco Bisotto on 4/27/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation
import UIKit

class EventsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var events: [Event]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.events = []
        
        navigationItem.title = "Events"
        tableView.contentInset.top = CGFloat(50)
        tableView.contentInset.bottom = CGFloat(70)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureTabAndNavigationControllers()
        
        
        EventStorage.getAll(orderByDate: true, handler: ParseHandler().handlerWithOnStart({ () -> Void in
            }, onSuccess: { (suc : ParseResult) -> Void in
                self.events = suc.Data as! [Event]
            }, onError: { (err) -> Void in
                println(err)
            }, onFinish: { () -> Void in
        }))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func configureTabAndNavigationControllers() {
        
        //Nav
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        //Tab
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.barTintColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        self.tabBarController?.tabBar.translucent = true
    }
    
    //MARK:  - TableVewDataSource
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("EventHeader") as! EventCustomTableViewHeader
        
        let event = events[section]
       
        headerCell.hostImageProfile.alpha = 0.0
        event.photo_profile.getDataInBackgroundWithBlock({ (data, err) -> Void in
            
            if err == nil {
                headerCell.hostImageProfile.image = UIImage(data: data!)!
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    headerCell.hostImageProfile.alpha = 1.0
                })
            }
        })

        headerCell.hostName.text = event.createdBy.username
        headerCell.hostImageProfile.layer.cornerRadius = headerCell.hostImageProfile.frame.size.width/2
        headerCell.hostImageProfile.layer.masksToBounds = true
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 125
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if events.count > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as! EventCustomTableViewCell

        cell.eventCoverImage.alpha = 0.0
        cell.gradientView.alpha = 0.0
        
        if let event = events[indexPath.section] as Event? {

            event.photo_cover.getDataInBackgroundWithBlock({ (data, err) -> Void in
                
                if err == nil {
                    cell.eventCoverImage.image = UIImage(data: data!)!
                    UIView.animateWithDuration(1.0, animations: { () -> Void in
                        cell.gradientView.alpha = 1.0
                        cell.eventCoverImage.alpha = 1.0
                    })
                }
            })
            cell.eventCoverImage.layer.masksToBounds = true
        
            cell.eventTitle.text = event.name as String
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEEE, dd/MMM - HH:mm"
            cell.eventDate.text = formatter.stringFromDate(event.datetime)
        
            cell.layer.masksToBounds = true
            
            return cell
        } else {
            return EventCustomTableViewCell()
        }
    }
}
