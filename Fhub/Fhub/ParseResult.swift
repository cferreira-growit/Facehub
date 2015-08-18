//
//  ParseResult.swift
//  BabyLife
//
//  Created by Francisco Ferreira on 5/4/15.
//  Copyright (c) 2015 Growit. All rights reserved.
//

import Foundation
import UIKit


class ParseResult{
    
    let Data: AnyObject?
    let Message: String?
    let Error: NSError?
    let ErrorCode: NSNumber?

    init(data: AnyObject?, message: String?, error: NSError?, errorCode: NSNumber?){
        self.Data = data
        self.Message = message
        self.Error = error
        self.ErrorCode = errorCode
    }
    
    init(dataSuccess: AnyObject){
        self.Data = dataSuccess
        self.Message = nil
        self.Error = nil
        self.ErrorCode = nil
    }
    init(dataError: NSError){
        self.Data = nil
        self.Message = dataError.userInfo?["error"] as? String
        self.Error = dataError
        self.ErrorCode = dataError.userInfo?["code"] as? NSNumber
    }
}