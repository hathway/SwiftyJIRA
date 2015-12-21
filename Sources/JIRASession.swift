//
//  JIRASession.swift
//  SwiftyJIRA
//
//  Created by Eneko Alonso on 8/29/14.
//  Copyright (c) 2014 Hathway. All rights reserved.
//

import Foundation
//import JSONRequest

typealias JIRAQueryParams = [String: AnyObject?]
typealias JIRAPayload = JIRAQueryParams

public class JIRASession {

    public static let sharedSession = JIRASession()

    var settings: [String : String]? = nil

    public func configure(host: String, version: String, username: String, password: String) {
        settings = ["host": host, "version": version, "user": username, "pass": password]
    }

    func get(urlPath: String, params: JIRAQueryParams) {

    }

    func post(urlPath: String, params: JIRAQueryParams, payload: JIRAPayload) {

    }

    func buildUrl(urlPath: String, params: JIRAQueryParams) {

    }

//    func request(urlPath: String, params: [String:AnyObject]?) {

//        var url = NSURL(string:settings!["host"]!)!
//            .URLByAppendingPathComponent("/rest/api/")
//            .URLByAppendingPathComponent(settings!["version"]!)
//            .URLByAppendingPathComponent(urlPath)
//
//        let login = NSString(format: "%@:%@", settings!["user"]!, settings!["pass"]!).dataUsingEncoding(NSUTF8StringEncoding)
//        let base64Login = login!.base64EncodedStringWithOptions([])
//        request.addValue("Basic \(base64Login)", forHTTPHeaderField: "Authorization")
//    }


}
