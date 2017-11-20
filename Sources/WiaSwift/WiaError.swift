//
//  WiaError.swift
//  WiaSwift_iOS
//
//  Created by Conall Laverty on 14/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// A WiaError represents an API error in Wia
public class WiaError: Mappable {
    
    /// The message of this WiaError
    public var message: String?
    
    /// The status code of this WiaError
    public var status: Int?
    
    // Constructor
    init(message: String? = nil, status: Int? = nil) {
        self.message = message
        self.status = status
    }
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        message <- map["message"]
        status <- map["status"]
    }
}
