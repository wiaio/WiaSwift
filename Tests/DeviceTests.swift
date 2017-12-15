//
//  DeviceTests.swift
//  WiaSwift
//
//  Created by Conall Laverty on 13/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

@testable import WiaSwift
import XCTest
import Nimble

class DeviceTests: XCTestCase {
    static let client = TestClientFactory.testClient()

    override func setUp() {
        super.setUp()
    
        let expectation = self.expectation(description: "Setting up device tests")

        DeviceTests.client.listSpaces(onSuccess: { spaces, count in
            expect(spaces).to(beAKindOf(Array<Space>.self))
            DeviceTests.client.spaceId = spaces[0].id
            expectation.fulfill()
        }, onFailure: { error in
            fail("Error retrieving list of spaces")
            expectation.fulfill()
        })
     
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testsCreateDeviceObject() {
        let deviceId = "dev_abcdef123"
        let deviceName = "Microverse battery"
        let device = Device(id: deviceId, name: deviceName)
        expect(device.id).to(equal(deviceId))
        expect(device.name).to(equal(deviceName))
    }
    
    func testListDevices() {
        let expectation = self.expectation(description: "Retrieves a list of devices")
        
        DeviceTests.client.listDevices(spaceId: DeviceTests.client.spaceId!, onSuccess: { devices, count in
            expect(devices).to(beAKindOf(Array<Device>.self))
            
            for device in devices {
                expect(device).to(beAKindOf(Device.self));
            }
            
            expectation.fulfill()
        }, onFailure: { error in
            expect(error).to(beAKindOf(WiaError.self))
            fail("Error status code \(error.status!)")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testRetrieveDevice() {
        let expectation = self.expectation(description: "Retrieve a device")
        
        DeviceTests.client.listDevices(spaceId: DeviceTests.client.spaceId!, onSuccess: { devices, count in
            expect(devices).to(beAKindOf(Array<Device>.self))
            
            let device = devices[0]
            expect(device.id).notTo(beNil())

            DeviceTests.client.retrieveDevice(id: device.id!, onSuccess: { device in
                expect(device).to(beAKindOf(Device.self))
                expect(device.name).notTo(beNil())
                expectation.fulfill()
            }, onFailure: { error in
                expect(error).to(beAKindOf(WiaError.self))
                fail("Error status code \(error.status!)")
            })
        }, onFailure: { error in
            expect(error).to(beAKindOf(WiaError.self))
            fail("Error status code \(error.status!)")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }

//    func testListSpacesBadAccessToken() {
//        let expectation = self.expectation(description: "Retrieves a list of spaces for a shared instance")
//        let client = TestClientFactory.testClient(accessToken: "abcdef")
//
//        client.listSpaces(onSuccess: { spaces, count in
//            expect(spaces).to(beNil())
//            expectation.fulfill()
//        }, onFailure: { error in
//            expectation.fulfill()
//        })
//
//        waitForExpectations(timeout: 10.0, handler: nil)
//    }
}

