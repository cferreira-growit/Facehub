//
// RoundedImage.swift
// weCare
//
// Created by Francisco Ferreira on 4/28/15.
// Copyright (c) 2015 weCorp. All rights reserved.
//

import UIKit

@IBDesignable
class GTImageView: UIImageView, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: Class Variables
    var picker: UIImagePickerController? = nil
    var optionMenu: UIAlertController!
    let pickerCreated: Bool = false
    var parentController: UIViewController!
    
    // MARK: Class Inspectables
    @IBInspectable var tapChange: Bool = false
    @IBInspectable var tapText: NSString = "Tap to Change"
    @IBInspectable var allowCrop: Bool = false
    @IBInspectable var isRounded: Bool = false
    @IBInspectable var borderWidth: UInt = 0
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet{
            self.layer.borderColor = self.borderColor.CGColor
        }
    }
    @IBInspectable var cornerRadius: UInt = 0
    
    // MARK: Class Functions
    override func prepareForInterfaceBuilder() { self.applyProperties() }
    
    override func awakeFromNib() {
        dispatch_async(dispatch_get_main_queue()){
            self.applyProperties()
        }
    }
    
    private func applyProperties(){
        self.layoutIfNeeded()
        
        self.layer.borderColor = self.borderColor.CGColor
        self.layer.borderWidth = CGFloat(self.borderWidth)
        
        if isRounded {
            self.clipsToBounds = true
            self.layer.cornerRadius = self.layer.bounds.size.width / 2
        }
        else if self.cornerRadius > 0 {
            self.clipsToBounds = true
            self.layer.cornerRadius = CGFloat(self.cornerRadius)
        }
        
        if self.tapChange {
            var tapGesture = UITapGestureRecognizer(target: self, action: "onTouchToChange:")
            self.userInteractionEnabled = true
            self.addGestureRecognizer(tapGesture)
            
            let lblTapChange: UILabel = UILabel(frame: CGRect(x: 0, y: 20, width: self.layer.bounds.size.width, height: self.layer.bounds.size.height * 0.2))
            lblTapChange.text = self.tapText as String
            lblTapChange.textColor = UIColor.whiteColor()
            lblTapChange.textAlignment = .Center
            lblTapChange.adjustsFontSizeToFitWidth = true
            lblTapChange.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
            lblTapChange.center.y = (self.layer.bounds.size.height / 2)
            
            self.addSubview(lblTapChange)
        }
    }
    
    func onTouchToChange(sender: UIButton){
        if !self.tapChange { return }
        
        if self.picker == nil {
            self.picker = UIImagePickerController()
            self.picker!.delegate = self
            self.picker!.allowsEditing = self.allowCrop
        }
        
        if !self.pickerCreated.boolValue {
            self.optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
            let deleteAction = UIAlertAction(title: "Take a Photo", style: .Default  , handler: {
                (alert: UIAlertAction!) -> Void in
                self.picker!.sourceType = UIImagePickerControllerSourceType.Camera
                self.parentController.presentViewController(self.picker!, animated: true, completion: nil)
            })
            let saveAction = UIAlertAction(title: "Choose Photo", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.parentController.presentViewController(self.picker!, animated: true, completion: nil)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
            })
            
            self.optionMenu.addAction(deleteAction)
            self.optionMenu.addAction(saveAction)
            self.optionMenu.addAction(cancelAction)
        }
        
        self.parentController.presentViewController(self.optionMenu, animated: true, completion: nil)
    }
    
    // MARK: Image Picker Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.parentController.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.image = info[(!self.allowCrop ? UIImagePickerControllerOriginalImage : UIImagePickerControllerEditedImage)] as! UIImage!
        })
    }
}