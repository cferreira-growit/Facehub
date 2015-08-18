//
//  ParseHandler.swift
//  BabyLife
//
//  Created by Francisco Ferreira on 5/4/15.
//  Copyright (c) 2015 Growit. All rights reserved.
//

import Foundation
import UIKit

class ParseHandler{
    
    private var blockOnStart: (() -> Void)!
    private var blockOnSuccess: ((ParseResult) -> Void)!
    private var blockOnError: ((ParseResult) -> Void)!
    private var blockOnFinish: (() -> Void)!
    
    func handlerWithOnStart(onStart: () -> Void,
        onSuccess: (suc: ParseResult) -> Void,
        onError: (err: ParseResult) -> Void,
        onFinish: () -> Void) -> ParseHandler {
            
            self.blockOnStart = onStart
            self.blockOnSuccess = onSuccess
            self.blockOnError = onError
            self.blockOnFinish = onFinish
            
            return self
    }
    
    func onStart(){ self.blockOnStart() }
    func onSuccess(dataSuccess: ParseResult){ self.blockOnSuccess(dataSuccess) }
    func onError(dataError: ParseResult){ self.blockOnError(dataError) }
    func onFinish(){ self.blockOnFinish() }
}