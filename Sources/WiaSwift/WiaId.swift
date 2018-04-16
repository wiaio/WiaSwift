//
//  WiaId.swift
//  WiaSwift
//
//  Created by Conall Laverty on 12/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// A WiaId represents a Wia object with an ID
open class WiaId: Mappable  {
    
    /// The ID of this Space
    public var id: String?

    // Constructor
    init(id: String? = nil) {
        self.id = id
    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
    }
}
