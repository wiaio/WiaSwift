//
//  CommandTests
//  WiaSwift_iOS
//
//  Created by Conall Laverty on 22/06/2018.
//  Copyright © 2018 Wia Technologies Limited. All rights reserved.
//

@testable import WiaSwift
import XCTest
import Nimble

class CommandTests: XCTestCase {
    static var client = TestClientFactory.testClient()
    
    override func setUp() {
        super.setUp()

        CommandTests.client.deviceId = ProcessInfo.processInfo.environment["WIA_DEVICE_ID"]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListCommands() {
        let expectation = self.expectation(description: "Retrieves a list of commands")
        
        CommandTests.client.listCommands(deviceId: CommandTests.client.deviceId!, onSuccess: { commands, count in
            expect(commands).to(beAKindOf(Array<Command>.self))
            
            for command in commands {
                expect(command).to(beAKindOf(Command.self));
                expect(command.id).toNot(beNil())
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

