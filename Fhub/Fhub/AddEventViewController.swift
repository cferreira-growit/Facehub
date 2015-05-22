//
//  AddEventViewController.swift
//  Fhub
//
//  Created by Francisco Ferreira on 5/20/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import UIKit

class AddEventViewController: AppViewController, UITextFieldDelegate {

    @IBOutlet weak var svScroll: UIScrollView!
    @IBOutlet weak var ivProfile: GTImageView!
    @IBOutlet weak var ivCover: GTImageView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfWhere: UITextField!
    @IBOutlet weak var tfWhen: UITextField!
    @IBOutlet weak var btGeoPosition: UIButton!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tvInformation: UITextView!
    
    @IBOutlet weak var consToBottom: NSLayoutConstraint!
    
    private var fields: [UITextField]!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ivProfile.parentController = self
        self.ivCover.parentController = self
        
        self.tvInformation.layer.borderWidth = 1
        self.tvInformation.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.fields = [self.tfName, self.tfWhere, self.tfWhen, self.tfPrice]
        for f: UITextField in self.fields {
            f.delegate = self
            f.layer.borderWidth = 1
            f.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.8).CGColor
            f.layer.cornerRadius = 9
            f.attributedPlaceholder = NSAttributedString(string: f.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.5)])
        }

        self.svScroll.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("closeKeyboard")))
        
        if let ev: Event = AppCore.ref.currEvent  {
            self.ivProfile.image = ev.loadedProfile
            self.ivCover.image = ev.loadedCover
            self.tfName.text = ev.name as String
            self.tfWhere.text = ev.address as String
            self.tfWhen.text = ev.datetime.toStringWithFormat(format: "EEE, dd/MM - HH:mm")
            self.tfPrice.text = NSString(format: "%d", ev.price) as String
            self.tvInformation.text = ev.information as String
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        super.setNavigationDefaultColors(self.navigationController?.navigationBar)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: Touch
    func closeKeyboard(){
        self.svScroll.endEditing(true)
    }
    
    // MARK: Text Field
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField === self.tfPrice {
            self.tvInformation.becomeFirstResponder()
        }
        else {
            var idx: Int = find(self.fields, textField)!
            self.fields[idx+1].becomeFirstResponder()
        }
        return true
    }
    
    // MARK: Navigation Buttons
    @IBAction func onTouchCancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onTouchSave(sender: UIBarButtonItem) {
        var fieldsOk: Bool = true
        for f: UITextField in self.fields {
            if f.text.isEmpty {
                fieldsOk = false
                break
            }
        }
        if self.tvInformation.text.isEmpty || self.ivCover.image == nil || self.ivProfile.image == nil {
            fieldsOk = false
        }
        if !fieldsOk {
            Functions.displaySingleButtonAlertWithTitle("Atention", message: "All fields are required, review them.", view: self)
        }
        else {
            EventStorage.add(self.tfName.text as String, information: self.tvInformation.text as String, datetime: NSDate(), address: self.tfWhere.text, address_geo: PFGeoPoint(latitude: 1, longitude: 1), price: 1, photo_profile: PFFile(data: self.ivProfile.image!.baseEncodedNSDataWithCompression(0.8)), photo_cover: PFFile(data: self.ivCover.image!.baseEncodedNSDataWithCompression(0.8)), handler: ParseHandler().handlerWithOnStart({ () -> Void in
                
                }, onSuccess: { (suc: ParseResult) -> Void in
                    println("foi")
                }, onError: { (err: ParseResult) -> Void in
                    println(err.Error)
                }, onFinish: { () -> Void in
                
            }))
        }
    }
}