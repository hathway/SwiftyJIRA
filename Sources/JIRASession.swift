//
//  JIRASession.swift
//  SwiftyJIRA
//
//  Created by Eneko Alonso on 8/29/14.
//  Copyright (c) 2014 Hathway. All rights reserved.
//

import Foundation
import SwiftyJSON
import JSONRequest


typealias JIRAQueryParams = [String: AnyObject?]
typealias JIRAPayload = AnyObject

public class JIRASession {

    public static let sharedSession = JIRASession()

    var apiHost: String?
    var apiVersion: String?
    var apiUser: String?
    var apiPass: String?
    var request: JSONRequest?

    public func configure(host: String, version: String, username: String, password: String) {
        apiHost = host
        apiUser = username
        apiPass = password
        apiVersion = version
        request = JSONRequest()
        configureAuthenticationHeaders()
    }

    func get(urlPath: String, params: JIRAQueryParams? = nil) -> JSONResult {
        guard let url = buildUrl(urlPath) else {
            return JSONResult.Failure(error: JSONError.InvalidURL, response: nil, body: nil)
        }
        guard let request = request else {
            return JSONResult.Failure(error: JSONError.RequestFailed, response: nil, body: nil)
        }
        return request.get(url, queryParams: params)
    }

    func post(urlPath: String, params: JIRAQueryParams? = nil, payload: JIRAPayload? = nil) -> JSONResult {
        guard let url = buildUrl(urlPath) else {
            return JSONResult.Failure(error: JSONError.InvalidURL, response: nil, body: nil)
        }
        guard let request = request else {
            return JSONResult.Failure(error: JSONError.RequestFailed, response: nil, body: nil)
        }
        return request.post(url, queryParams: params, payload: payload)
    }

    func put(urlPath: String, params: JIRAQueryParams? = nil, payload: JIRAPayload? = nil) -> JSONResult {
        guard let url = buildUrl(urlPath) else {
            return JSONResult.Failure(error: JSONError.InvalidURL, response: nil, body: nil)
        }
        guard let request = request else {
            return JSONResult.Failure(error: JSONError.RequestFailed, response: nil, body: nil)
        }
        return request.put(url, queryParams: params, payload: payload)
    }

    func buildUrl(urlPath: String) -> String? {
        return NSURL(string: apiHost ?? "")?
            .URLByAppendingPathComponent("/rest/api")
            .URLByAppendingPathComponent(apiVersion ?? "")
            .URLByAppendingPathComponent(urlPath ?? "")
            .absoluteString
    }

    func configureAuthenticationHeaders() {
        guard let user = apiUser else {
            return
        }
        guard let pass = apiPass else {
            return
        }

        let login = String(format: "%@:%@", user, pass).dataUsingEncoding(NSUTF8StringEncoding)
        if let base64Login = login?.base64EncodedStringWithOptions([]) {
            request?.httpRequest?.addValue("Basic \(base64Login)", forHTTPHeaderField: "Authorization")
        }
    }
    
}
