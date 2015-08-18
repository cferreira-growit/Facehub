//
//  UserProfileViewController.swift
//  Fhub
//
//  Created by Guilherme Moresco Bisotto on 5/14/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation
import UIKit


var type = [0: "E-mail", 1: "RG", 2: "Birthday",3: "Address"]

class UserProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userProfilePhoto: UIImageView!
    @IBOutlet weak var userCoverProfilePhoto: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    
    //MARK: - Variables
    var isEnableFields: Bool = false
    var data = []
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        configureTabAndNavigationControllers(navigationController?.navigationBar)
        
        userProfilePhoto.layer.cornerRadius = userProfilePhoto.bounds.width/2
        userProfilePhoto.layer.masksToBounds = true
        userCoverProfilePhoto.layer.masksToBounds = true
        
        //addBlurEffect(userCoverProfilePhoto)
        userCoverProfilePhoto.alpha = 0.4
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MMM/yyyy"
        var birthday: String!
        var email: String!
        var location: String!
        var rg: String!
        
        if let date = User.currentUser().birthday as NSDate? {
            birthday = formatter.stringFromDate(date)
        } else {
            birthday = "Preencha a data de seu nascimento"
        }
        
        if let em = User.currentUser().email as String? {
            email = em
        } else {
            email = "E-mail não informado"
        }
        
        if let loc = User.currentUser().location as String? {
            location = loc
        } else {
            location = "Endereço não informado"
        }
        
        if let userRG = User.currentUser().rg as String? {
            rg = userRG
        } else {
            rg = "RG não informado"
        }

        self.data = [email,
                    rg,
                    birthday,
                    location]
        
        self.username.text = User.currentUser().username
        self.name.text = "\(User.currentUser().first_name) \(User.currentUser().last_name)"
        
        User.currentUser().photo.getDataInBackgroundWithBlock { (data, err) -> Void in
            if err == nil {
                self.userProfilePhoto.image = UIImage(data: data!)
            }
        }
        
        User.currentUser().photo.getDataInBackgroundWithBlock { (data, err) -> Void in
            if err == nil {
                self.userCoverProfilePhoto.image = UIImage(data: data!)
            }
        }
        
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 0
        
        switch (section) {
            case 0:
                numberOfRows = 3
                break
            case 1:
                numberOfRows = 1
                break
            default:
                numberOfRows = 0
                break
        }
        
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("UserDataCell", forIndexPath: indexPath) as! ProfileCustomTableViewCell
            
            cell.dataType.text = type[indexPath.row]
            
            if !isEnableFields && indexPath.row == 1 {
                var originalRG: String
                
                if data[indexPath.row] as! String != "RG não informado" {
                    originalRG = data[indexPath.row] as! String
                    
                    let startIndex = advance(originalRG.startIndex, 0)
                    let endIndex = advance(startIndex, 4)
                    let range = startIndex..<endIndex
                    let customRG = originalRG[range]
                    cell.dataTextField.text = customRG + "XXXX"
                } else {
                    cell.dataTextField.text = data[indexPath.row] as! String
                }
            } else {
                cell.dataTextField.text = data[indexPath.row] as! String
            }
            
            cell.dataTextField.enabled = isEnableFields
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("UserAddressCell", forIndexPath: indexPath) as! ProfileAddressCustomTableViewCell
            
            cell.dataType.text = type[indexPath.row + 3]
            cell.addressButton.setTitle(data[indexPath.row + 3] as? String, forState: UIControlState.Normal)
            
            return cell
        }
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