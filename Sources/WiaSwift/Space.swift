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
public class Space: Mappable  {
    
    /// The ID of this Space
    public var id: String?
    
    /// The name of this Space
    public var name: String?
    
    // Constructor
    init(id: String? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
