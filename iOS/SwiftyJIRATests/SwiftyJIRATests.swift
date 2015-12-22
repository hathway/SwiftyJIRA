//
//  SwiftyJIRATests.swift
//  SwiftyJIRATests
//
//  Created by Eneko Alonso on 4/29/15.
//  Copyright (c) 2015 Hathway, Inc. All rights reserved.
//

import XCTest
@testable import SwiftyJIRA

class SwiftyJIRATests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        if let path = NSBundle(forClass: SwiftyJIRATests.self).pathForResource("Config", ofType: "plist") {
            if let config = NSDictionary(contentsOfFile: path) as? [String : AnyObject] {
                let host = config["JIRAHost"] as? String ?? ""
                let user = config["JIRAUser"] as? String ?? ""
                let pass = config["JIRAPass"] as? String ?? ""
                JIRASession.sharedSession.configure(host, version: "latest", username: user, password: pass)
            }
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testServerInfo() {
        let result = JIRASession.sharedSession.get("serverinfo", params: ["doHealthCheck": false])
        print(result.data)
    }
    
}
