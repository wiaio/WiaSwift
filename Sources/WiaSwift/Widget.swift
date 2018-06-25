//
//  Widget.swift
//  WiaSwift
//
//  Created by Conall Laverty on 23/06/2018.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

open class Widget: Mappable {
    
    // The ID of this Widget
    public var id: String?
    
    // The name of this Widget
    public var typeId: Int?
    
    // The name of this Widget
    public var name: String?

    // The config of this Widget
    public var config: Any?
    
    // The created at timestamp of this Widget
    public var createdAt: Date?

    // The updated at timestamp of this Widget
    public var updatedAt: Date?

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
        typeId <- map["typeId"]
        name <- map["name"]
        config <- map["config"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
    }
}
