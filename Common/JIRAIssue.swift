//
//  JIRAIssue.swift
//  jira
//
//  Created by Eneko Alonso on 8/31/14.
//  Copyright (c) 2014 Hathway. All rights reserved.
//

import Foundation

typealias JIRAIssueList = [JIRAIssue]
typealias JIRAIssueCallback = (JIRAIssueList?, NSError?) -> Void


class JIRAIssue: NSObject {

    /// Class method to retrieve a single JIRA issue by Key
    class func issue(issueKey: String, callback: JIRAIssueCallback) {
        JIRASession.get("issue/\(issueKey)", params: nil) { (json, response, error) in
            // TODO: Parse results into JIRAIssue instances
            callback([], nil)
        }
    }
    
    class func search(query: String, callback: JIRAIssueCallback) {
        let payload:[String:AnyObject] = [
            "jql": query,
            "startAt": 0,
            "maxResults": 10,
            "fields": [
                "summary",
                "status",
                "issueType"
            ]
        ]
        JIRASession.post("search", params: nil, payload: payload) { (json, response, error) in
            // TODO: Parse results into JIRAIssue instances
            callback([], nil)
        }
    }
    
}
