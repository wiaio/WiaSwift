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
    
    /// The device type
    public var type: DeviceType?

    /// The events of this Device
    public var events: [Event]?

    /// The location of this Device
    public var location: Location?
    
    /// The state of this Device
    public var state: Any?

    // Constructor
    init(id: String? = nil, name: String? = nil, type: DeviceType? = nil) {
        self.id = id
        self.name = name
        self.type = type
    }
    
    public required init?(){
        
    }

    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
        events <- map["events"]
        location <- map["location"]
        state <- map["state"]
    }
}
