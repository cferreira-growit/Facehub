//
//  InitialController.swift
//  Fhub
//
//  Created by Guilherme Moresco Bisotto on 5/4/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation
import UIKit

class InitialController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var tfUsernameSign: UITextField!
    @IBOutlet weak var tfEmailSign: UITextField!
    @IBOutlet weak var tfPasswordSign: UITextField!
    
    @IBOutlet weak var consToLeft: NSLayoutConstraint!
    @IBOutlet weak var consToBottom: NSLayoutConstraint!
    
    @IBOutlet weak var vLogin: UIView!
    
    private var fields: [UITextField]!
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        self.fields = [self.tfUsername, self.tfPassword, self.tfUsernameSign, self.tfEmailSign, self.tfPasswordSign]
        
        for f: UITextField in self.fields {
            f.delegate = self
            f.layer.borderWidth = 1
            f.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.8).CGColor
            f.layer.cornerRadius = 11
            f.attributedPlaceholder = NSAttributedString(string: f.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.5)])
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    
    //MARK: Keyboard Methods
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        UIView.animateWithDuration(1) {
            self.consToBottom.constant = keyboardFrame!.height + 5
            self.view.layoutIfNeeded()
        }
    }
    func keyboardWillHide(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        UIView.animateWithDuration(1) {
            self.consToBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType == UIReturnKeyType.Go {
            if textField === self.tfPassword {
                self.performSignIn()
            }
            else {
                self.performSignUp()
            }
            self.view.endEditing(true)
        }
        else {
            var idx: Int = find(self.fields, textField)!
            self.fields[idx+1].becomeFirstResponder()
        }
        return true
    }


    // MARK: Touch Buttons
    @IBAction func onTouchLogin(sender: UIButton) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.consToLeft.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    @IBAction func onTouchSignUp(sender: UIButton) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.consToLeft.constant = -UIScreen.mainScreen().bounds.size.width
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: Class Functions
    private func performSignIn(){
        UserStorage.signInWithUsername(self.tfPassword.text, password: self.tfPassword.text, handler: ParseHandler().handlerWithOnStart({ () -> Void in
        }, onSuccess: { (suc) -> Void in
            Functions.displaySingleButtonAlertWithTitle("Success", message: "SignIn Success!\n\nIMPLEMENT THIS", view: self)
        }, onError: { (err) -> Void in
            Functions.displayTwoButtonAlertWithTitle("Atention", message: "Invalid Credentials!\n\nWould you like to create a new account?", view: self, buttonOneTitle: "Yes", buttonOneBlock: { () -> () in
                
            }, buttonTwoTitle: "No")
        }, onFinish: { () -> Void in
            
        }))
    }
    private func performSignUp(){
        UserStorage.signUpWithUsername(self.tfUsernameSign.text, password: self.tfPasswordSign.text, email: self.tfEmailSign.text, handler: ParseHandler().handlerWithOnStart({ () -> Void in
            }, onSuccess: { (suc: ParseResult) -> Void in
                Functions.displaySingleButtonAlertWithTitle("Success", message: "SignUp Success!\n\nIMPLEMENT THIS", view: self)
            }, onError: { (err: ParseResult) -> Void in
                Functions.displaySingleButtonAlertWithTitle("Atention", message: err.Message!, view: self)
            }, onFinish: { () -> Void in
                
        }))
    }
}