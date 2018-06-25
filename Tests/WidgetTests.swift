//
//  WidgetTests
//  WiaSwift_iOS
//
//  Created by Conall Laverty on 22/06/2018.
//  Copyright © 2018 Wia Technologies Limited. All rights reserved.
//

@testable import WiaSwift
import XCTest
import Nimble

class WidgetTests: XCTestCase {
    static var client = TestClientFactory.testClient()
    
    override func setUp() {
        super.setUp()
        
        WidgetTests.client.deviceId = ProcessInfo.processInfo.environment["WIA_DEVICE_ID"]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListCommands() {
        let expectation = self.expectation(description: "Retrieves a list of widgets")
        
        WidgetTests.client.listWidgets(deviceId: WidgetTests.client.deviceId!, onSuccess: { widgets, count in
            expect(widgets).to(beAKindOf(Array<Widget>.self))
            
            for widget in widgets {
                expect(widget).to(beAKindOf(Widget.self));
                expect(widget.id).toNot(beNil())
            }
            
            expectation.fulfill()
        }, onFailure: { error in
            expect(error).to(beAKindOf(WiaError.self))
            fail("Error status code \(error.status!)")
            expectation.fulfill()
        });
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}

