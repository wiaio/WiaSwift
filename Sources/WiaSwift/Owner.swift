//
//  Owner.swift
//  WiaSwift_iOS
//
//  Created by Conall Laverty on 12/12/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// Owner represents an organisation in Wia
open class Owner: Mappable  {
    
    /// The owner user
    public var user: User?
    
    /// The owner organisation
    public var organisation: Organisation?
    
    // Constructor
//    init() {
//    }
//    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }

    public func mapping(map: Map) {
        user <- map["user"]
        organisation <- map["organisation"]
    }
}

