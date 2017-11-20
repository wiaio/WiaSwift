//
//  Device.swift
//  WiaSwift
//
//  Created by Conall Laverty on 13/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// A Device represents a thing in Wia
open class Device: Mappable {
    
    /// The ID of this Device
    public var id: String?
    
    /// The name of this Device
    public var name: String?
    
    /// The events of this Device
    public var events: [String: Event]?

    /// The location of this Device
    public var location: Location?
    
    // Constructor
    init(id: String? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
    
    public required init?(){
        
    }

    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        events <- map["events"]
        location <- map["location"]
    }
}
