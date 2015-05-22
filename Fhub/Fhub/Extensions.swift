//
//  LBExtensions.swift
//  LifeBaby
//
//  Created by Francisco Ferreira on 4/10/15.
//  Copyright (c) 2015 CFerreira. All rights reserved.
//

import UIKit

extension UInt32{
    func random() -> UInt32 {
        return arc4random_uniform(UInt32.max)
    }
}
extension NSDate{
    convenience
    init(dateString: String, format: String = "yyyy-MM-dd") {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = format
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
    func toStringWithFormat(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
        
    }
    var dateYearAsString: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.stringFromDate(self)
    }
    
    var BirthdayAsString: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(self)
    }
}

extension String {
    var length: Int { return count(self) }
}

extension UIImage {
    func baseEncodedNSDataWithCompression(compress: CGFloat) -> NSData {
        return UIImageJPEGRepresentation(self, compress)
    }
    func baseEncoded64WithCompression(compress: CGFloat) -> NSString {
        var imgData: NSData = UIImageJPEGRepresentation(self, compress)
        return imgData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }
    func resizeTo(size: CGSize) -> UIImage{
        let currSize = CGSizeApplyAffineTransform(self.size, CGAffineTransformMakeScale(size.width, size.height))
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(currSize, !hasAlpha, scale)
        self.drawInRect(CGRect(origin: CGPointZero, size: currSize))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage.imageWithRenderingMode(.AlwaysTemplate)
    }
}