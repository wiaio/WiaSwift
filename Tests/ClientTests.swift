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
        print("Setting up tests in TestClientFactory")

        let client: Wia
        let testAppKey = appKey ?? ProcessInfo.processInfo.environment["WIA_TEST_APP_KEY"]
        let testClientKey = clientKey ?? ProcessInfo.processInfo.environment["WIA_TEST_CLIENT_KEY"]
        let testAccessToken = accessToken ?? ProcessInfo.processInfo.environment["WIA_TEST_USER_ACCESS_TOKEN"]
        let testBaseURL = baseURL ?? ProcessInfo.processInfo.environment["WIA_TEST_API_BASE_URL"]

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
