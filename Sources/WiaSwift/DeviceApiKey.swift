//
//  DeviceSecretKey.swift
//  WiaSwift
//
//  Created by Conall Laverty on 23/03/2019.
//  Copyright © 2019 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// A Device represents a thing in Wia
open class DeviceApiKey: Mappable {
    
    /// The ID of this Device
    public var secretKey: String?
    
    // Constructor
    init(secretKey: String? = nil) {
        self.secretKey = secretKey
    }
    
    public required init?(){
        
    }
    
    public required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        secretKey <- map["secretKey"]
    }
}
