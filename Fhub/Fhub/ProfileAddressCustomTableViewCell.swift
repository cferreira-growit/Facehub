//
//  ProfileAddressCustomTableViewCell.swift
//  Fhub
//
//  Created by Guilherme Moresco Bisotto on 5/14/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation
import UIKit

class ProfileAddressCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var dataType: UILabel!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var icon: UIImageView!
    
    @IBAction func ShowAndChangeAddress(sender: AnyObject) {
        println("Endereço da birosca de pessoa")
    }
}
