//
//  Location.swift
//  WiaSwift
//
//  Created by Conall Laverty on 14/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// Represents an Location in Wia
open class Location: Mappable  {
    
    /// The ID of this Location
    public var id: String?
    
    /// The latitude of this Location
    public var latitude: Double?
    
    /// The longitude of this Location
    public var longitude: Double?

    /// The longitude of this Location
    public var altitude: Double?

    /// The timestamp of this Location
    public var timestamp: Date?

    // Constructor
    init(id: String? = nil, latitude: Double? = nil, longitude: Double? = nil, altitude: Double? = nil, timestamp: Date? = nil) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.timestamp = timestamp
    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }

    public func mapping(map: Map) {
        id <- map["id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        altitude <- map["altitude"]
        
        if (String(describing: map["timestamp"]).contains(":")) {
            timestamp <- (map["timestamp"], NativeISO8601DateTransform())
        } else {
            timestamp <- (map["timestamp"], MilisecondDateTransform())
        }
    }
}

