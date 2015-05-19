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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Events"
        configureTabAndNavigationControllers(navigationController?.navigationBar)
        collectionView.contentInset.bottom = CGFloat(70)
    }
    
    func configureTabAndNavigationControllers(navBar: UINavigationBar!) {
        navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navBar.shadowImage = UIImage()
        navBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        navBar.tintColor = UIColor.whiteColor()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyEvents", forIndexPath: indexPath) as! MyEventsCustomCollectionViewCell
        
        cell.titleEvent.text = "Clube da Luta"
        
        cell.coverImage.image = UIImage(named: "beco-cover")
        cell.coverImage.layer.cornerRadius = 10
        cell.coverImage.layer.masksToBounds = true
        cell.coverImage.alpha = 0.4
                
        cell.iconImage.image = UIImage(named: "beco-icon")
        cell.iconImage.layer.cornerRadius = cell.iconImage.frame.size.width/2
        cell.iconImage.layer.masksToBounds = true
        
        if cell.coverImage.layer.sublayers != nil {
            cell.coverImage.layer.sublayers.removeAtIndex(0)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
