//
//  Avatar.swift
//  WiaSwift_iOS
//
//  Created by Conall Laverty on 18/05/2019.
//  Copyright © 2019 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

open class Avatar: Mappable  {
    
    public var url: String?

    public var thumbnail: String?
    
    // Constructor
    init(url: String? = nil, thumbnail: String? = nil) {
        self.url = url
        self.thumbnail = thumbnail
    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        url <- map["url"]
        thumbnail <- map["thumbnail"]
    }
}
