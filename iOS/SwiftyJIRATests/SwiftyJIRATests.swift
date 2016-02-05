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

    var jiraHost = ""
    var jiraUser = ""
    var jiraPass = ""

    override func setUp() {
        super.setUp()
        let bundle = NSBundle(forClass: SwiftyJIRATests.self)
        if let path = bundle.pathForResource("Config", ofType: "plist") {
            if let config = NSDictionary(contentsOfFile: path) as? [String : AnyObject] {
                jiraHost = config["JIRAHost"] as? String ?? ""
                jiraUser = config["JIRAUser"] as? String ?? ""
                jiraPass = config["JIRAPass"] as? String ?? ""
                JIRASession.sharedSession.configure(jiraHost, version: "latest",
                    username: jiraUser, password: jiraPass)
            }
        }
    }

    func testConfigNotEmpty() {
        let session = JIRASession.sharedSession
        XCTAssertNotEqual(session.apiVersion, "")
        XCTAssertNotEqual(session.apiHost, "")
        XCTAssertNotEqual(session.apiUser, "")
        XCTAssertNotEqual(session.apiPass, "")
    }

    func testConfigLoaded() {
        let session = JIRASession.sharedSession
        XCTAssertEqual(session.apiVersion, "latest")
        XCTAssertEqual(session.apiHost, jiraHost)
        XCTAssertEqual(session.apiUser, jiraUser)
        XCTAssertEqual(session.apiPass, jiraPass)
    }

    func testServerInfo() {
        let serverInfo = JIRAServerInfo.serverInfo()
        XCTAssertNotNil(serverInfo)
        XCTAssertEqual(serverInfo?.baseUrl, jiraHost)
        XCTAssertEqual(serverInfo?.versionNumbers.count, 3)
    }

}
