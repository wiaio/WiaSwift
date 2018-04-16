//
//  UserTests.swift
//  WiaSwift_iOS
//
//  Created by Conall Laverty on 14/11/2017.
//  Copyright © 2017 Wia Technologies Limited. All rights reserved.
//

@testable import WiaSwift
import XCTest
import Nimble

class UserTests: XCTestCase {
    static var client = TestClientFactory.testClient()

    override func setUp() {
        super.setUp()
        
        UserTests.client.spaceId = ProcessInfo.processInfo.environment["WIA_SPACE_ID"]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListUsers() {
        let expectation = self.expectation(description: "Retrieves a list of users")
        
        UserTests.client.listUsers(spaceId: DeviceTests.client.spaceId!, onSuccess: { users, count in
            expect(users).to(beAKindOf(Array<User>.self))
            
            for user in users {
                expect(user).to(beAKindOf(User.self));
                expect(user.id).toNot(beNil())
            }
            
            expectation.fulfill()
        }, onFailure: { error in
            expect(error).to(beAKindOf(WiaError.self))
            fail("Error status code \(error.status!)")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testRetrieveUser() {
        let expectation = self.expectation(description: "Retrieves a user")
        
        UserTests.client.listUsers(spaceId: DeviceTests.client.spaceId!, onSuccess: { users, count in
            expect(users).to(beAKindOf(Array<User>.self))
            let user = users[0]
            expect(user.id).notTo(beNil())
            
            UserTests.client.retrieveUser(id: user.id!, onSuccess: { user in
                expect(user).to(beAKindOf(User.self))
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
    
//    func testSignupUser() {
//        UserTests.client.reset()
//        UserTests.client.clientKey = "ck_gJFaBw3CLpwDuMHzuwCpkTdG2NskS"
//
//        let expectation = self.expectation(description: "Signs up a user")
//
//        let fullName = HelperUtils.randomString(length: 16) + " " + HelperUtils.randomString(length: 16)
//        let username = HelperUtils.randomString(length: 16) + "@" + HelperUtils.randomString(length: 16) + ".com"
//        let password = HelperUtils.randomString(length: 16)
//
//        UserTests.client.signupUser(fullName: fullName, username: username, password: password, onSuccess: { user in
//            expect(user).to(beAKindOf(User.self))
//            expect(user.id).notTo(beNil())
//            expect(user.fullName).notTo(beNil())
//            expectation.fulfill()
//        }, onFailure: { error in
//            expect(error).to(beAKindOf(WiaError.self))
//            fail("Error status code \(error.status!)")
//            expectation.fulfill()
//        })
//
//        waitForExpectations(timeout: 10.0, handler: nil)
//    }
    
//    func testLoginUser() {
//        UserTests.client.reset()
//        UserTests.client.clientKey = "ck_gJFaBw3CLpwDuMHzuwCpkTdG2NskS"
//        
//        let expectation = self.expectation(description: "Logins a user")
//        
//        let fullName = HelperUtils.randomString(length: 16) + " " + HelperUtils.randomString(length: 16)
//        let username = HelperUtils.randomString(length: 16) + "@" + HelperUtils.randomString(length: 16) + ".com"
//        let password = HelperUtils.randomString(length: 16)
//        
//        UserTests.client.signupUser(fullName: fullName, username: username, password: password, onSuccess: { user in
//            expect(user).to(beAKindOf(User.self))
//            expect(user.id).notTo(beNil())
//            expect(user.fullName).notTo(beNil())
//            
//            UserTests.client.loginUser(username: username, password: password, onSuccess: { accessToken in
//                expect(accessToken).to(beAKindOf(AccessToken.self))
//                expectation.fulfill()
//            }, onFailure: { error in
//                expect(error).to(beAKindOf(WiaError.self))
//                fail("Error status code \(error.status!)")
//                expectation.fulfill()
//            })
//        }, onFailure: { error in
//            expect(error).to(beAKindOf(WiaError.self))
//            fail("Error status code \(error.status!)")
//            expectation.fulfill()
//        })
//        
//        waitForExpectations(timeout: 10.0, handler: nil)
//    }
    
    func testRetrieveCurrentUser() {
        let expectation = self.expectation(description: "Retrieve the currently authenticated user")
        
        UserTests.client.retrieveUser(id: "me", onSuccess: { user in
            expect(user).to(beAKindOf(User.self))
            expect(user.id).toNot(beNil())
            expectation.fulfill()
        }, onFailure: { error in
            expect(error).to(beAKindOf(WiaError.self))
            fail("Error status code \(error.status!)")
            expectation.fulfill()
        })

        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testRetrieveAndSetCurrentUser() {
        let expectation = self.expectation(description: "Retrieve the currently authenticated user")
        
        UserTests.client.retrieveUser(id: "me", onSuccess: { user in
            expect(user).to(beAKindOf(User.self))
            expect(user.id).toNot(beNil())
            UserTests.client.currentUser = user
            expectation.fulfill()
        }, onFailure: { error in
            expect(error).to(beAKindOf(WiaError.self))
            fail("Error status code \(error.status!)")
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0, handler: nil)
    }

}

