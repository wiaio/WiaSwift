//
//  SpaceTests.swift
//  WiaSwift
//
//  Created by Conall Laverty on 12/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

@testable import WiaSwift
import XCTest
import Nimble

class SpaceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListSpaces() {
        let expectation = self.expectation(description: "Retrieves a list of spaces")
        let client = TestClientFactory.testClient()

        client.listSpaces(onSuccess: { spaces, count in
            expect(spaces).to(beAKindOf(Array<Space>.self))
            
            for space in spaces {
                expect(space).to(beAKindOf(Space.self));
            }

            expectation.fulfill()
        }, onFailure: { error in
            expect(error).to(beAKindOf(WiaError.self))
            fail("Error status code \(error.status!)")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testRetrieveSpace() {
        let expectation = self.expectation(description: "Retrieve a space")
        let client = TestClientFactory.testClient()
        
        client.listSpaces(onSuccess: { spaces, count in
            expect(spaces).to(beAKindOf(Array<Space>.self))
            let space = spaces[0]
            expect(space.id).notTo(beNil())
            
            client.retrieveSpace(id: space.id!, onSuccess: { space in
                expect(space).to(beAKindOf(Space.self))
                expectation.fulfill()
            }, onFailure: { error in
                expect(error).to(beAKindOf(WiaError.self))
                fail("Error status code \(error.status!)")
                expectation.fulfill()
            })
        }, onFailure: { error in
            expect(error).to(beAKindOf(WiaError.self))
            fail("Error status code \(error.status!)")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testListSpacesBadAccessToken() {
        let expectation = self.expectation(description: "Retrieves a list of spaces for a shared instance")
        let client = TestClientFactory.testClient(accessToken: "abcdef")
        
        client.listSpaces(onSuccess: { spaces, count in
            expect(spaces).to(beNil())
            expectation.fulfill()
        }, onFailure: { error in
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}

