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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Events"
        configureTabAndNavigationControllers(navigationController?.navigationBar)
        tableView.contentInset.top = CGFloat(50)
        tableView.contentInset.bottom = CGFloat(70)
        
    }
    
    func configureTabAndNavigationControllers(navBar: UINavigationBar!) {
        navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navBar.shadowImage = UIImage()
        navBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        navBar.tintColor = UIColor.whiteColor()
    }
    
    //MARK:  - TableVewDataSource
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("EventHeader") as! EventCustomTableViewHeader
        
        headerCell.hostName.text = "Beco203"
        headerCell.hostImageProfile.image = UIImage(named: "beco-icon")
        headerCell.hostImageProfile.layer.cornerRadius = headerCell.hostImageProfile.frame.size.width/2
        headerCell.hostImageProfile.layer.masksToBounds = true
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventCustomTableViewCell

        cell.eventCoverImage.image = UIImage()
        cell.eventCoverImage.image = UIImage(named: "beco-cover")
        cell.eventCoverImage.layer.masksToBounds = true
        
        cell.eventTitle.text = "Clube da Luta"
        cell.eventDate.text = "Sex 27/Set 2015 - 22h"
        
        cell.layer.masksToBounds = true
                
        if cell.eventCoverImage.layer.sublayers != nil {
            cell.eventCoverImage.layer.sublayers.removeAtIndex(0)
        }
        
        adddGradient(cell.bounds, gradient: cell.eventCoverImage)
        
        return cell
    }
    
    //MARK: - Layout
    func adddGradient(bounds: CGRect, gradient: UIView) {
        let colorLeft = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).CGColor
        let colorRight = UIColor.clearColor().CGColor
        let layer: CAGradientLayer = CAGradientLayer()
        
        layer.opacity = 0.8
        layer.colors = [colorLeft, colorRight]
        
        layer.startPoint = CGPointMake(0.0, 0.5)
        layer.endPoint = CGPointMake(1.0, 0.5)
        
        let gradTopStart = NSNumber(float: 0.5)
        let gradTopEnd = NSNumber(float: 1.0)
        let gradBottomStart = NSNumber(float: 0.5)
        let gradBottomEnd = NSNumber(float: 1.0)
        layer.locations = [gradTopStart, gradTopEnd, gradBottomStart, gradBottomEnd]
        
        layer.bounds = bounds
        layer.anchorPoint = CGPointZero
        layer.masksToBounds = true
        
        gradient.layer.addSublayer(layer)
    }
}
