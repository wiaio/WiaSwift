//
//  Organisation.swift
//  WiaSwift_iOS
//
//  Created by Conall Laverty on 12/12/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// Organisation represents an organisation in Wia
open class Organisation: Mappable  {
    
    /// The ID of this Organisation
    public var id: String?
    
    /// The full name of this Organisation
    public var name: String?
    
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
    }
}
