//
//  AccessToken.swift
//  WiaSwift_iOS
//
//  Created by Conall Laverty on 14/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// An AccessToken represents a access token in Wia
open class AccessToken: Mappable {
    
    /// The token
    public var token: String?
    
    // Constructor
    init(token: String? = nil) {
        self.token = token
    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }

    public func mapping(map: Map) {
        token <- map["token"]
    }
}
