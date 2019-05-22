//
//  Event.swift
//  WiaSwift
//
//  Created by Conall Laverty on 14/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// Represents an Event in Wia
public class Event: Mappable  {
    
    /// The ID of this Event
    public var id: String?
    
    /// The name of this Event
    public var name: String?
    
    /// The data of this Event
    public var data: Any?
    
    /// The file of this Event
    public var file: Any?

    /// The timestamp of this Event
    public var timestamp: Date?

    /// The raw timestamp of this Event
    public var timestampRaw: String?

    // Constructor
    init(id: String? = nil, name: String? = nil, data: Any? = nil, file: Any? = nil, timestamp: Date? = nil) {
        self.id = id
        self.name = name
        self.data = data
        self.file = file
        self.timestamp = timestamp
    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }

    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        data <- map["data"]
        file <- map["file"]
        timestampRaw <- map["timestamp"]
        
        let timestampBuf = (map["timestamp"], MilisecondDateTransform())
        
        if (timestampBuf != nil) {
            timestamp <- timestampBuf
        } else {
            timestamp <- (map["timestamp"], NativeISO8601DateTransform())
        }
    }
}
