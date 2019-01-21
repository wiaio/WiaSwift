//
//  DeviceType.swift
//  WiaSwift
//
//  Created by Conall Laverty on 13/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// A device type
open class DeviceType: Mappable {
    
    /// The ID of this device type
    public var id: Int?
    
    /// The manufacturer of this device type
    public var manufacturer: String?
    
    /// The model of this device type
    public var model: String?

    // Constructor
    init(id: Int? = nil, model: String? = nil, manufacturer: String? = nil) {
        self.id = id
        self.model = model
        self.manufacturer = manufacturer
    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        model <- map["model"]
        manufacturer <- map["manufacturer"]
    }
}
