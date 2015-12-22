//
//  JIRAIssue.swift
//  SwiftyJIRA
//
//  Created by Eneko Alonso on 8/31/14.
//  Copyright (c) 2014 Hathway. All rights reserved.
//

import Foundation

public struct JIRAIssue {

    var issueKey: String
    var summary: String
    var issueType: String
    var status: String

}


// MARK: Active Record

public extension JIRAIssue {

    public static func issue(issueKey: String) -> JIRAIssue? {
        let result = JIRASession.sharedSession.get("issue/\(issueKey)", params: JIRAQueryParams())
        switch result {
        case .Success(let data, let response):
            print(data)
            // TODO: Parse response and return JIRAIssue instance
            break
        case .Failure(let error, let response):
            break
        }
        return nil
    }

    public static func search(query: String) -> [JIRAIssue] {
        let payload: JIRAPayload = [
            "jql": query,
            "startAt": 0,
            "maxResults": 100,
            "fields": [
                "summary",
                "status",
                "issueType"
            ]
        ]
        let result = JIRASession.sharedSession.post("search", params: JIRAQueryParams(), payload: payload)
        print(result.data)
        return []
    }

}
