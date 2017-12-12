//
//  Wia.swift
//  WiaSwift
//
//  Created by Conall Laverty on 12/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

/// Client object for performing requests against the Wia API.
open class Wia {
    public static let sharedInstance: Wia = {
        let instance = Wia()
        return instance
    }()
    
    open var appKey: String?
    open var clientKey: String?
    open var accessToken: String?
    open var baseURL: String
    open var spaceId: String?
    open var currentUser: User?
    
    public init(appKey: String? = nil,
         clientKey: String? = nil,
         accessToken: String? = nil,
         baseURL: String? = nil) {
        self.appKey = appKey
        self.clientKey = clientKey
        self.accessToken = accessToken
        self.baseURL = baseURL ?? "https://api.wia.io/v1"
        self.spaceId = nil
    }
    
    public func reset() {
        self.appKey = nil
        self.clientKey = nil
        self.accessToken = nil
        self.spaceId = nil
    }
    
    // Spaces
    public func retrieveSpace(id: String,
                    onSuccess success: @escaping (Space) -> Void,
                    onFailure failure: @escaping (WiaError) -> Void) {
        Alamofire.request(requestUrl(path: "/spaces/" + id),
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: self.generateHeaders()
            ).validate().responseObject { (response: DataResponse<Space>) in
                switch response.result {
                case .success:
                    let space = response.result.value!
                    success(space)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    public func listSpaces(limit: Int? = nil,
                    page: Int? = nil,
                    onSuccess success: @escaping ([Space],Int?) -> Void,
                    onFailure failure: @escaping (WiaError) -> Void) {
        let params: [String:String] = ["limit": "40"]

        Alamofire.request(requestUrl(path: "/spaces"),
                          method: .get,
                          parameters: params,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "spaces") { (response: DataResponse<[Space]>) in
            switch response.result {
            case .success:
                let spaces = response.result.value ?? []
                success(spaces,spaces.count)
                return
            case .failure:
                let wiaError = WiaError(status: response.response?.statusCode)
                failure(wiaError)
                return
            }
        }
    }
    
    // Devices
    public func retrieveDevice(id: String,
                       onSuccess success: @escaping (Device) -> Void,
                       onFailure failure: @escaping (WiaError) -> Void) {
        Alamofire.request(requestUrl(path: "/devices/" + id),
                          method: .get,
                          headers: self.generateHeaders()
            ).validate().responseObject { (response: DataResponse<Device>) in
                switch response.result {
                case .success:
                    let device = response.result.value!
                    success(device)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    public func listDevices(spaceId: String,
                    limit: Int? = nil,
                    page: Int? = nil,
                    onSuccess success: @escaping ([Device],Int?) -> Void,
                    onFailure failure: @escaping (WiaError) -> Void) {
        
        let params = ["spaceId": spaceId]
        
        Alamofire.request(requestUrl(path: "/devices"),
                          method: .get,
                          parameters: params,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "devices") { (response: DataResponse<[Device]>) in
                switch response.result {
                case .success:
                    let devices = response.result.value ?? []
                    success(devices,devices.count)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    // Users
    public func retrieveUser(id: String,
                        onSuccess success: @escaping (User) -> Void,
                        onFailure failure: @escaping (WiaError) -> Void) {
        Alamofire.request(requestUrl(path: "/users/" + id),
                          method: .get,
                          headers: self.generateHeaders()
            ).validate().responseObject { (response: DataResponse<User>) in
                switch response.result {
                case .success:
                    let user = response.result.value!
                    success(user)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    public func listUsers(spaceId: String,
                     limit: Int? = nil,
                     page: Int? = nil,
                     onSuccess success: @escaping ([User],Int?) -> Void,
                     onFailure failure: @escaping (WiaError) -> Void) {
        
        let params = ["spaceId": spaceId]
        
        Alamofire.request(requestUrl(path: "/users"),
                          method: .get,
                          parameters: params,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "users") { (response: DataResponse<[User]>) in
                switch response.result {
                case .success:
                    let users = response.result.value ?? []
                    success(users,users.count)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    // Users
    public func loginUser(username: String,
               password: String,
                  onSuccess success: @escaping (AccessToken) -> Void,
                  onFailure failure: @escaping (WiaError) -> Void) {
        let parameters: Parameters = [
            "username": username,
            "password": password,
            "scope": "user",
            "grantType": "password"
        ]

        Alamofire.request(requestUrl(path: "/auth/token"),
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: self.generateHeaders()
            ).validate().responseObject { (response: DataResponse<AccessToken>) in
                switch response.result {
                case .success:
                    let accessToken = response.result.value!
                    success(accessToken)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    public func signupUser(fullName: String,
                    username: String,
                   password: String,
                   onSuccess success: @escaping (User) -> Void,
                   onFailure failure: @escaping (WiaError) -> Void) {
        let parameters: Parameters = [
            "fullName": fullName,
            "emailAddress": username,
            "password": password
        ]
        
        Alamofire.request(requestUrl(path: "/users"),
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: self.generateHeaders()
            ).validate().responseObject { (response: DataResponse<User>) in
                switch response.result {
                case .success:
                    let user = response.result.value!
                    success(user)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    public func logoutUser(onSuccess success: @escaping () -> Void,
                    onFailure failure: @escaping (WiaError) -> Void) {
        self.accessToken = nil
    }

    private func requestUrl(path: String) -> String {
        return baseURL + path
    }
    
    private func generateHeaders() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        if let ak = self.appKey {
            headers["X-App-Key"] = ak
        }
        
        if let ck = self.clientKey {
            headers["X-Client-Key"] = ck
        }
        
        if let token = self.accessToken {
            headers["Authorization"] = "Bearer " + token
        }
        
        return headers;
    }
}
