//
//  JIRAIssue.swift
//  SwiftyJIRA
//
//  Created by Eneko Alonso on 8/31/14.
//  Copyright (c) 2014 Hathway. All rights reserved.
//

import Foundation

typealias JIRAIssueList = [JIRAIssue]
typealias JIRAIssueCallback = (JIRAIssueList?, NSError?) -> Void


class JIRAIssue: NSObject {

    /// Class method to retrieve a single JIRA issue by Key
    func issue(issueKey: String, callback: JIRAIssueCallback) {
//        JIRASession.get("issue/\(issueKey)", params: nil) { (json, response, error) in
//            // TODO: Parse results into JIRAIssue instances
//            callback([], nil)
//        }
        JIRASession.sharedSession.get("issue/\(issueKey)", params: JIRAQueryParams())
    }
    
    func search(query: String, callback: JIRAIssueCallback) {
        let payload: JIRAPayload = [
            "jql": query,
            "startAt": 0,
            "maxResults": 10,
            "fields": [
                "summary",
                "status",
                "issueType"
            ]
        ]
        JIRASession.sharedSession.post("search", params: JIRAQueryParams(), payload: payload)
    }
    
}
