//
//  JIRASessionTests.swift
//  SwiftyJIRA
//
//  Created by Eneko Alonso on 4/21/15.
//  Copyright (c) 2015 Hathway, Inc. All rights reserved.
//

import XCTest
@testable import SwiftyJIRA

class JIRASessionTests: XCTestCase {

    var JIRAHost: String?
    var JIRAUser: String?
    var JIRAPass: String?
    
    override func setUp() {
        super.setUp()

        if let path = NSBundle(forClass: JIRASessionTests.self).pathForResource("Config", ofType: "plist") {
            if let config = NSDictionary(contentsOfFile: path) as? [String : AnyObject] {
                JIRAHost = config["JIRAHost"] as? String
                JIRAUser = config["JIRAUser"] as? String
                JIRAPass = config["JIRAPass"] as? String
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNoSettings() {
//        JIRASession.get("test", params: nil) { (result, response, error) -> Void in
//            XCTAssertNotNil(error, "Error not nil")
//            if error != nil {
//                XCTAssertEqual(error!.code, -1, "Error code -1")
//                XCTAssertEqual(error!.domain, "JIRASession", "Error domain")
//            }
//        }
    }

    func testServerInfo() {
        let expectation = self.expectationWithDescription("JIRA")

//        JIRASession.initialize(JIRAHost!, version: "latest", username: JIRAUser!, password: JIRAPass!)
//        JIRASession.get("serverinfo", params: ["doHealthCheck": "false"]) { (result, response, error) -> Void in
////            println(result)
////            println(response)
////            println(error)
            expectation.fulfill()
//        }
        self.waitForExpectationsWithTimeout(5.0, handler: nil)
    }

    func testUser() {
        let expectation = self.expectationWithDescription("JIRA")
        
//        JIRASession.initialize(JIRAHost!, version: "latest", username: JIRAUser!, password: JIRAPass!)
//        JIRASession.get("user", params: ["username": JIRAUser!]) { (result, response, error) -> Void in
//            XCTAssertNil(error, "No error retrieving user")
//            XCTAssertNotNil(response, "Got response")
//            XCTAssertNotNil(result, "Got result")
//            XCTAssertEqual(result?["key"] as? String, self.JIRAUser, "Username matches")
//            XCTAssertEqual(result?["name"] as? String, self.JIRAUser, "Username matches")
            expectation.fulfill()
//        }
        self.waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
}
