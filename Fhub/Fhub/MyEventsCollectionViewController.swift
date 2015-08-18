//
//  MyEventsCollectionViewController.swift
//  Fhub
//
//  Created by Guilherme Moresco Bisotto on 5/8/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import Foundation
import UIKit

class MyEventsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    var myEvents: [EventParticipant]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myEvents = []
        
        navigationItem.title = "My Events"
        configureTabAndNavigationControllers(navigationController?.navigationBar)
        collectionView.contentInset.bottom = CGFloat(70)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        UserStorage.getMyEvents(orderByDate: true, handler: ParseHandler().handlerWithOnStart({ () -> Void in
            }, onSuccess: { (suc: ParseResult) -> Void in
                self.myEvents = suc.Data as! [EventParticipant]
                self.collectionView.reloadData()
            }, onError: { (err: ParseResult) -> Void in
                println(err)
            }, onFinish: { () -> Void in
        }))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.myEvents = []
        self.collectionView.reloadData()
    }
    
    func configureTabAndNavigationControllers(navBar: UINavigationBar!) {
        navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navBar.shadowImage = UIImage()
        navBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        navBar.tintColor = UIColor.whiteColor()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyEvents", forIndexPath: indexPath) as! MyEventsCustomCollectionViewCell
        
        let event = myEvents[indexPath.row]
        
        cell.titleEvent.text = event.belongsTo.name as String
        
        cell.coverImage.layer.cornerRadius = 10
        cell.coverImage.layer.masksToBounds = true

        cell.coverImage.alpha = 0.0
        event.belongsTo.photo_cover.getDataInBackgroundWithBlock { (data , err) -> Void in
            
            if err == nil {
                cell.coverImage.image = UIImage(data: data!)!
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    cell.coverImage.alpha = 0.4
                })
            }
        }
        
        cell.iconImage.layer.cornerRadius = cell.iconImage.frame.size.width/2
        cell.iconImage.layer.masksToBounds = true
        
        cell.glowEffectImage.alpha = 0.0
        cell.iconImage.alpha = 0.0
        
        event.belongsTo.photo_profile.getDataInBackgroundWithBlock { (data , err) -> Void in
            
            if err == nil {
                cell.iconImage.image = UIImage(data: data!)!
                cell.glowEffectImage.image = UIImage(named: "Glow-effect")
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    cell.glowEffectImage.alpha = 1.0
                    cell.iconImage.alpha = 1.0
                })
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myEvents.count
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize
    {
        let screenSize = view.bounds
        return CGSize(width: (screenSize.width/2)-15, height: 150)
    }
    
    //MARK: - Layout
    func adddGradient(bounds: CGRect, gradient: UIView) {
        let colorLeft = UIColor.whiteColor().CGColor
        let colorRight = UIColor.whiteColor().CGColor
        let layer: CAGradientLayer = CAGradientLayer()
        
        layer.opacity = 0.3
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
