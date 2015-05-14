//
//  UserProfileViewController.swift
//  Fhub
//
//  Created by Guilherme Moresco Bisotto on 5/14/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userProfilePhoto: UIImageView!
    @IBOutlet weak var userCoverProfilePhoto: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var isEnableFields: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        configureTabAndNavigationControllers(navigationController?.navigationBar)
        
        userProfilePhoto.layer.cornerRadius = userProfilePhoto.bounds.width/2
        userProfilePhoto.layer.masksToBounds = true
        
        //addBlurEffect(userCoverProfilePhoto)
        userCoverProfilePhoto.alpha = 0.4
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ProfileCustomTableViewCell
        let cellSize = cell.bounds.height
        
        if (tableView.frame.origin.y + (cellSize*4)) > view.frame.height - 55 {
            tableView.scrollEnabled = true
        } else {
            tableView.scrollEnabled = false
        }
        
    }
    
    //MARK: - TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("UserDataCell", forIndexPath: indexPath) as! ProfileCustomTableViewCell
        
        cell.dataType.text = "E-mail"
        cell.dataTextField.text = "guibisotto@gmail.com"
        
        cell.dataTextField.enabled = isEnableFields
        
        return cell
    }
    
    @IBAction func editingFields(sender: AnyObject) {
        
        isEnableFields = !isEnableFields
        tableView.reloadData()
    }
    
    func configureTabAndNavigationControllers(navBar: UINavigationBar!) {
        navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navBar.shadowImage = UIImage()
        navBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        navBar.tintColor = UIColor.whiteColor()
    }
}