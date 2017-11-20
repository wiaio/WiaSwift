//
//  ClientTests.swift
//  WiaSwift
//
//  Created by Conall Laverty on 12/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

@testable import WiaSwift
import XCTest
import Nimble

struct TestClientFactory {
    
    static func testClient(appKey: String? = nil,
                           clientKey: String? = nil,
                           accessToken: String? = nil,
                           baseURL: String? = nil) -> Wia {
        let client: Wia
        let testAppKey = appKey ?? nil
        let testClientKey = clientKey ?? "ck_gJFaBw3CLpwDuMHzuwCpkTdG2NskS"
        let testAccessToken = accessToken ?? "u_at_QrygMzIlSUaiakTytPOVILpNcTmwMvdO"
        let testBaseURL = baseURL ?? "http://localhost:9000/v1"

        client = Wia(appKey: testAppKey, clientKey: testClientKey, accessToken: testAccessToken, baseURL: testBaseURL)
        
        return client
    }
}

class ClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
