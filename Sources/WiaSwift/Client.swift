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
    open var deviceId: String?
    open var currentUser: User?
    
    public init(appKey: String? = nil,
         clientKey: String? = nil,
         accessToken: String? = nil,
         baseURL: String? = nil) {
        self.appKey = appKey
        self.clientKey = clientKey
        self.accessToken = accessToken
        self.baseURL = baseURL ?? "api.wia.io/v1"
        self.spaceId = nil
        self.deviceId = nil
    }
    
    public func reset() {
        self.appKey = nil
        self.clientKey = nil
        self.accessToken = nil
        self.spaceId = nil
        self.deviceId = nil
    }
    
    // Spaces
    public func createSpace(name: String,
                             onSuccess success: @escaping (Space) -> Void,
                             onFailure failure: @escaping (WiaError) -> Void) {
        let parameters: Parameters = [
            "name": name
        ]

        Alamofire.request(requestUrl(path: "/spaces"),
                          method: .post,
                          parameters: parameters,
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
        let params: [String:String] = [
            "limit": limit != nil ? "\(String(describing: limit))" : "100"
        ]

        Alamofire.request(requestUrl(path: "/spaces"),
                          method: .get,
                          parameters: params,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "spaces") { (response: DataResponse<[Space]>) in
            switch response.result {
            case .success:
                let spaces = response.result.value ?? []

//                var newSpaceArray:[Space] = []
//                response.result.value!?.forEach({ (space) in
//                    let s:Space = Space.init(id: space.id, name: space.name)
//                    s.owner = space.owner
//                    s.avatar = space.avatar
//                    newSpaceArray.append(s)
//                })

                success(spaces, spaces.count)
                
                //                success(spaces, spaces.count)
                return
            case .failure:
                let wiaError = WiaError(status: response.response?.statusCode)
                failure(wiaError)
                return
            }
        }
    }
    
    // Devices
    public func createDevice(name: String,
                           deviceTypeId: Int,
                           spaceId: String,
                           serialNumber: String? = nil,
                           onSuccess success: @escaping (Device) -> Void,
                           onFailure failure: @escaping (WiaError) -> Void) {
        var parameters: Parameters = [
            "name": name,
            "deviceTypeId": deviceTypeId,
            "spaceId": spaceId
        ]
        
        if (serialNumber != nil) {
            parameters["serialNumber"] = serialNumber
        }
        
        Alamofire.request(requestUrl(path: "/devices"),
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
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
    
    public func updateDevice(deviceId: String,
                             name: String? = nil,
                             state: [String: String]? = nil,
                             onSuccess success: @escaping (Device) -> Void,
                             onFailure failure: @escaping (WiaError) -> Void) {
        var parameters: Parameters = [:]
        
        if (name != nil) {
            parameters["name"] = name
        }
        
        if (state != nil) {
            parameters["state"] = state
        }

        Alamofire.request(requestUrl(path: "/devices/" + deviceId),
                          method: .put,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
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
        
        let params = ["space.id": spaceId]
        
        let devicesEndpoint: String = requestUrl(path: "/devices");
        
        Alamofire.request(devicesEndpoint,
                          method: .get,
                          parameters: params,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "devices") { (response: DataResponse<[Device]>) in
                debugPrint(response)

                switch response.result {
                case .success:
                    let devices = response.result.value! ?? []
                    success(devices, devices.count)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    public func listDeviceTypes(onSuccess success: @escaping ([DeviceType],Int?) -> Void,
                            onFailure failure: @escaping (WiaError) -> Void) {
        
        let devicesEndpoint: String = requestUrl(path: "/devices/types");
        
        Alamofire.request(devicesEndpoint,
                          method: .get,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "deviceTypes") { (response: DataResponse<[DeviceType]>) in
                debugPrint(response)
                
                switch response.result {
                case .success:
                    let deviceTypes = response.result.value! ?? []
                    success(deviceTypes,deviceTypes.count)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    public func retrieveDeviceApiKey(id: String,
                             onSuccess success: @escaping (DeviceApiKey) -> Void,
                             onFailure failure: @escaping (WiaError) -> Void) {
        Alamofire.request(requestUrl(path: "/devices/" + id + "/apiKeys"),
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: self.generateHeaders()
            ).validate().responseObject { (response: DataResponse<DeviceApiKey>) in
                switch response.result {
                case .success:
                    let apiKey = response.result.value!
                    success(apiKey)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }

    public func sendDeviceGetStarted(deviceId: String,
                             onSuccess success: @escaping (Device) -> Void,
                             onFailure failure: @escaping (WiaError) -> Void) {
        
        Alamofire.request(requestUrl(path: "/devices/\(deviceId)/sendGetStarted"),
                          method: .post,
                          encoding: JSONEncoding.default,
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

    // Users
    public func retrieveUser(id: String,
                        onSuccess success: @escaping (User) -> Void,
                        onFailure failure: @escaping (WiaError) -> Void) {
        Alamofire.request(requestUrl(path: "/users/" + id),
                          method: .get,
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
    
    public func listUsers(spaceId: String,
                     limit: Int? = nil,
                     page: Int? = nil,
                     onSuccess success: @escaping ([User],Int?) -> Void,
                     onFailure failure: @escaping (WiaError) -> Void) {
        
        let params = ["space.id": spaceId]
        
        Alamofire.request(requestUrl(path: "/users"),
                          method: .get,
                          parameters: params,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "users") { (response: DataResponse<[User]>) in
                switch response.result {
                case .success:
                    let users = response.result.value! ?? []
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
                   over13Consent: Bool = false,
                   newsletterConsent: Bool = false,
                   onSuccess success: @escaping (User) -> Void,
                   onFailure failure: @escaping (WiaError) -> Void) {
        let parameters: Parameters = [
            "fullName": fullName,
            "emailAddress": username,
            "password": password,
            "over13Consent": over13Consent,
            "newsletterConsent":newsletterConsent
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
    
    public func registerNotificationDevice(token: String,
                                           type: String,
                                           onSuccess success: @escaping (WiaId) -> Void,
                                           onFailure failure: @escaping (WiaError) -> Void) {
        let parameters: Parameters = [
            "token": token,
            "type": type
        ]
        
        Alamofire.request(requestUrl(path: "/notifications/register"),
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: self.generateHeaders()
            ).validate().responseObject { (response: DataResponse<WiaId>) in
                switch response.result {
                case .success:
                    let wiaId = response.result.value!
                    success(wiaId)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }

    // Commands
    public func runCommand(deviceId: String,
                           commandSlug: String,
                           onSuccess success: @escaping (CommandStatus) -> Void,
                           onFailure failure: @escaping (WiaError) -> Void) {
        let parameters: Parameters = [
            "device.id": deviceId,
            "slug": commandSlug
        ]
        
        Alamofire.request(requestUrl(path: "/commands/run"),
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: self.generateHeaders()
            ).validate().responseObject { (response: DataResponse<CommandStatus>) in
                switch response.result {
                case .success:
                    let commandStatus = response.result.value!
                    success(commandStatus)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    public func listCommands(deviceId: String,
                            limit: Int? = nil,
                            page: Int? = nil,
                            onSuccess success: @escaping ([Command],Int?) -> Void,
                            onFailure failure: @escaping (WiaError) -> Void) {
        
        let params = ["device.id": deviceId]
        
        Alamofire.request(requestUrl(path: "/commands"),
                          method: .get,
                          parameters: params,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "commands") { (response: DataResponse<[Command]>) in
                switch response.result {
                case .success:
                    let commands = response.result.value!
                    success(commands,commands.count)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    // Widgets
    public func listWidgets(deviceId: String,
                             limit: Int? = nil,
                             page: Int? = nil,
                             onSuccess success: @escaping ([Widget],Int?) -> Void,
                             onFailure failure: @escaping (WiaError) -> Void) {
        
        let params = ["device.id": deviceId]
        
        Alamofire.request(requestUrl(path: "/widgets"),
                          method: .get,
                          parameters: params,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "widgets") { (response: DataResponse<[Widget]>) in
                switch response.result {
                case .success:
                    let widgets = response.result.value ?? []
                    success(widgets,widgets.count)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }
    
    // Events
    public func createEvent(deviceSecretKey: String,
                            name: String,
                            data: Any?,
                            onSuccess success: @escaping (Event) -> Void,
                            onFailure failure: @escaping (WiaError) -> Void) {
        var parameters: Parameters = [
            "name": name,
            "data": data
        ]
        
        var headers: HTTPHeaders = self.generateHeaders()
        headers["Authorization"] = "Bearer " + deviceSecretKey

        Alamofire.request(requestUrl(path: "/events"),
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers
            ).validate().responseObject { (response: DataResponse<Event>) in
                switch response.result {
                case .success:
                    let event = response.result.value!
                    success(event)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }

    public func listEvents(deviceId: String,
                            limit: Int? = nil,
                            page: Int? = nil,
                            onSuccess success: @escaping ([Event],Int?) -> Void,
                            onFailure failure: @escaping (WiaError) -> Void) {
        
        let params = [
            "device.id": deviceId,
            "limit": limit != nil ? "\(String(describing: limit))" : "100"
            ]
        
        let eventsEndpoint: String = requestUrl(path: "/events");

        Alamofire.request(eventsEndpoint,
                          method: .get,
                          parameters: params,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "events") { (response: DataResponse<[Event]>) in
                debugPrint(response)
                
                switch response.result {
                case .success:
                    let events = response.result.value!
                    success(events, events.count)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }

    // Locations
    public func createLocation(deviceSecretKey: String,
                               latitude: Double,
                               longitude: Double,
                               altitude: Double?,
                               onSuccess success: @escaping (Location) -> Void,
                               onFailure failure: @escaping (WiaError) -> Void) {
        var parameters: Parameters = [
            "latitude": latitude,
            "longitude": longitude
        ]
        
        if let alt = altitude {
            parameters["altitude"] = alt
        }

        var headers: HTTPHeaders = self.generateHeaders()
        headers["Authorization"] = "Bearer " + deviceSecretKey
        
        Alamofire.request(requestUrl(path: "/locations"),
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers
            ).validate().responseObject { (response: DataResponse<Location>) in
                switch response.result {
                case .success:
                    let location = response.result.value!
                    success(location)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }

    public func listLocations(deviceId: String,
                           limit: Int? = nil,
                           page: Int? = nil,
                           onSuccess success: @escaping ([Location],Int?) -> Void,
                           onFailure failure: @escaping (WiaError) -> Void) {
        
        let params = [
            "device.id": deviceId,
            "limit": limit != nil ? "\(String(describing: limit))" : "100"
        ]
        
        let eventsEndpoint: String = requestUrl(path: "/locations");
        
        Alamofire.request(eventsEndpoint,
                          method: .get,
                          parameters: params,
                          headers: self.generateHeaders()
            ).validate().responseArray(keyPath: "locations") { (response: DataResponse<[Location]>) in
                debugPrint(response)
                
                switch response.result {
                case .success:
                    let locations = response.result.value!
                    success(locations, locations.count)
                    return
                case .failure:
                    let wiaError = WiaError(status: response.response?.statusCode)
                    failure(wiaError)
                    return
                }
        }
    }

    private func requestUrl(path: String) -> String {
        return "https://" + baseURL + path
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
