//
//  Space.swift
//  WiaSwift
//
//  Created by Conall Laverty on 12/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// A Space represents a collection of Devices in Wia
open class Space: Mappable  {
    
    /// The ID of this Space
    public var id: String?
    
    /// The name of this Space
    public var name: String?
    
    // The owner of this Spaces
    public var owner: Owner?
    
    // The avatar of this Space
    public var avatar: Avatar?
    
    // Constructor
    init(id: String? = nil, name: String? = nil, owner: Owner? = nil, avatar: Avatar? = nil) {
        self.id = id
        self.name = name
        self.owner = owner
        self.avatar = avatar
    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }

    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        owner <- map["owner"]
        avatar <- map["avatar"]
    }
}
