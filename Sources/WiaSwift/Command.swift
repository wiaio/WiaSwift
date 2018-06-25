//
//  Command.swift
//  WiaSwift
//
//  Created by Conall Laverty on 22/06/2018.
//  Copyright © 2018 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// Represents a Command in Wia
public class Command: Mappable  {
    
    /// The ID of this Command
    public var id: String?
    
    /// The name of this Command
    public var name: String?
    
    /// The slug of this Command
    public var slug: String?
    
    // Constructor
    init(id: String? = nil, name: String? = nil, slug: String? = nil) {
        self.id = id
        self.name = name
        self.slug = slug
    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
    }
}

/// Represents a CommandStatus in Wia
public class CommandStatus: Mappable  {
    
    /// The ID of this Command
    public var id: String?
    
    /// The running of this Command
    public var running: Bool?

    // Constructor
    init(id: String? = nil, running: Bool? = false) {
        self.id = id
        self.running = running
    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        running <- map["running"]
    }
}
