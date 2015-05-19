//
//  ViewController.swift
//  Fhub
//
//  Created by Francisco Ferreira on 4/23/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var lblLoginStatus: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var profilePicture: FBSDKProfilePictureView!
    
    //MARK: - Variables
    var userLogged: FBSDKProfile!
    var friends = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onProfileUpdated:", name:FBSDKProfileDidChangeNotification, object: nil)
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            //TODO: show next view controller
        }
    }
    
    func onProfileUpdated(notification: NSNotification)
    {
        userLogged = FBSDKProfile.currentProfile()
        if userLogged != nil {
            //TODO: salvar usuario logado no keychain
            getFriends()
        }
    }
    
    func getFriends() {
        var fbRequest = FBSDKGraphRequest(graphPath:"/me/friends", parameters: nil);
        fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            if error == nil {
                println("Friends are : \(result)")
            } else {
                println("Error Getting Friends \(error)");
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      }

    func toggleHiddenState(shouldHide : Bool) {
        lblUsername.hidden = shouldHide;
        lblEmail.hidden = shouldHide;
        profilePicture.hidden = shouldHide;
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        println("entray")
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("Vazay")
    }

}