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
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
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