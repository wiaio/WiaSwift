//
//  Util.swift
//  WiaSwift_iOS
//
//  Created by Conall Laverty on 13/12/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import ObjectMapper

class MilisecondDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = Double
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let timeInt = value as? Double {
            return Date(timeIntervalSince1970: TimeInterval(timeInt / 1000))
        }
        
        if let timeStr = value as? String {
            return Date(timeIntervalSince1970: TimeInterval(atof(timeStr)  / 1000))
        }
        
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> Double? {
        if let date = value {
            return Double(date.timeIntervalSince1970)
        }
        return nil
    }
}

class NativeISO8601DateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public let dateFormatter: ISO8601DateFormatter
    
    public init() {
        self.dateFormatter = ISO8601DateFormatter()
    }
    
    public init(dateFormatter: ISO8601DateFormatter) {
        self.dateFormatter = dateFormatter
    }
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            //remove milliseconds
            let range = dateString.startIndex..<dateString.endIndex
            let trimmedString = dateString.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression, range: range)
            
            return dateFormatter.date(from: trimmedString)
        }
        
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}

