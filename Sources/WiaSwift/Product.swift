//
//  Product.swift
//  WiaSwift
//
//  Created by Conall Laverty on 13/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

open class Product: Mappable {
    
    public var id: String?
    
    public var manufacturer: String?
    
    public var model: String?
    
    public var name: String?
    
    public var colour: String?
    
    public var image: String?
    
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
        manufacturer <- map["manufacturer"]
        model <- map["model"]
        name <- map["name"]
        colour <- map["colour"]
        image <- map["image"]
    }
}

