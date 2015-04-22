//
//  JIRASessionTests.swift
//  SwiftyJIRA
//
//  Created by Eneko Alonso on 4/21/15.
//  Copyright (c) 2015 Hathway, Inc. All rights reserved.
//

import Cocoa
import XCTest

class JIRASessionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNoSettings() {
        JIRASession.get("test", params: nil) { (result, response, error) -> Void in
            XCTAssertNotNil(error, "Error not nil")
            if error != nil {
                XCTAssertEqual(error!.code, -1, "Error code -1")
                XCTAssertEqual(error!.domain, "JIRASession", "Error domain")
            }
        }
    }

}
