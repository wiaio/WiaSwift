//
//  User.swift
//  WiaSwift_iOS
//
//  Created by Conall Laverty on 14/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

/// A User represents a user in Wia
open class User: Mappable  {
    
    /// The ID of this User
    public var id: String?
    
    /// The full name of this User
    public var fullName: String?
    
    /// The username of this User
    public var username: String?

    /// The email address of this User
    public var emailAddress: String?

    // Constructor
    init(id: String? = nil, fullName: String? = nil, username: String? = nil, emailAddress: String? = nil) {
        self.id = id
        self.fullName = fullName
        self.username = username
        self.emailAddress = emailAddress
    }
    
    public required init?(){
        
    }

    public required init?(map: Map){
        
    }

    public func mapping(map: Map) {
        id <- map["id"]
        fullName <- map["fullName"]
        username <- map["username"]
        emailAddress <- map["emailAddress"]
    }
}
