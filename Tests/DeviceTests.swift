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
    
        DeviceTests.client.spaceId = ProcessInfo.processInfo.environment["WIA_TEST_SPACE_ID"]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testsCreateDevice() {
        let deviceTypeId = 1001
        let deviceName = "Microverse battery"
        
        let expectation = self.expectation(description: "Creates a device")
        
        DeviceTests.client.createDevice(name: deviceName,
                                        deviceTypeId: deviceTypeId,
                                        spaceId: DeviceTests.client.spaceId!,
                                        onSuccess: { device in
            expect(device).to(beAKindOf(Device.self))
            
            expect(device.id).toNot(beNil())
            expect(device.name).to(equal(deviceName))
            expect(device.type).toNot(beNil())
            expect(device.type).to(beAKindOf(DeviceType.self))
            expect(device.type?.id).toNot(beNil())
            expect(device.type?.model).toNot(beNil())
            expect(device.type?.manufacturer).toNot(beNil())
                                            
            expectation.fulfill()
        }, onFailure: { error in
            expect(error).to(beAKindOf(WiaError.self))
            fail("Error status code \(error.status!)")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
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
    
//    func testListDeviceTypes() {
//        let expectation = self.expectation(description: "Retrieves a list of device types")
//        
//        DeviceTests.client.listDeviceTypes(onSuccess: { deviceTypes, count in
//            expect(deviceTypes).to(beAKindOf(Array<DeviceType>.self))
//            
//            for deviceType in deviceTypes {
//                expect(deviceType).to(beAKindOf(DeviceType.self));
//                expect(deviceType.id).notTo(beNil())
//                expect(deviceType.model).notTo(beNil())
//                expect(deviceType.manufacturer).notTo(beNil())
//            }
//            
//            expectation.fulfill()
//        }, onFailure: { error in
//            expect(error).to(beAKindOf(WiaError.self))
//            fail("Error status code \(error.status!)")
//            expectation.fulfill()
//        })
//        
//        waitForExpectations(timeout: 10.0, handler: nil)
//    }
}

