//
//  JIRAIssue.swift
//  jira
//
//  Created by Eneko Alonso on 8/31/14.
//  Copyright (c) 2014 Hathway. All rights reserved.
//

import Foundation

class JIRAIssue: NSObject {

    class func issue(issueID:String, callback: JIRARequestCallback) {
        JIRASession.get("issue/\(issueID)", params: nil, callback: callback)
    }
    
    class func search(query: String, callback: JIRARequestCallback) {
        let payload = [
            "jql": query,
            "startAt": 0,
            "maxResults": 10,
            "fields": [
                "summary",
                "status",
                "issueType"
            ]
        ]
        JIRASession.post("search", payload: payload, callback: callback)
    }
    
}
