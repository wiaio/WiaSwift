//
//  EventQuery.swift
//  WiaSwift
//
//  Created by Conall Laverty on 14/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

public class EventQuery: Mappable  {
    
    public var value: Double?

    public var timestamp: Date?
    
    // Constructor
//    init(value: Double? = nil, timestamp: Date? = nil) {
//        self.value = value
//        self.timestamp = timestamp
//    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        value <- map["value"]

        if (String(describing: map["timestamp"]).contains(":")) {
            timestamp <- (map["timestamp"], NativeISO8601DateTransform())
        } else {
            timestamp <- (map["timestamp"], MilisecondDateTransform())
        }
    }
}
