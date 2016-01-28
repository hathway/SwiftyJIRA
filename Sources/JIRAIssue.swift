//
//  JIRAIssue.swift
//  SwiftyJIRA
//
//  Created by Eneko Alonso on 8/31/14.
//  Copyright (c) 2014 Hathway. All rights reserved.
//

import Foundation
import SwiftyJSON


//protocol IssueType {
//
//    var issueId: String { get set }
//    var issueKey: String { get set }
//    var summary: String { get set }
//    var issueType: JIRAIssueType { get set }
//    var status: String { get set }
//
//}

//public struct JIRAIssue: IssueType {
public class JIRAIssue {

    var issueId: String?
    var issueKey: String?
    var project: JIRAProject?

    var summary: String
    var issueType: JIRAIssueType

    var status: String?

    // TODO: Simplify parent to avoid grand-parent recursion
    var parent: JIRAIssue?

    init(summary: String, issueType: JIRAIssueType) {
        self.summary = summary
        self.issueType = issueType
    }

    init(json: JSON) {
        issueId = json["id"].stringValue
        issueKey = json["key"].stringValue
        issueType = JIRAIssueType(json: json["fields"]["issuetype"])
        summary = json["fields"]["summary"].stringValue
        status = json["fields"]["status"]["name"].stringValue

        if json["fields"]["project"] != JSON.null {
            project = JIRAProject(json: json["fields"]["project"])
        }

        if json["fields"]["parent"] != JSON.null {
            parent = JIRAIssue(json: json["fields"]["parent"])
        }
    }

}


// MARK: Active Record (Query)

public extension JIRAIssue {

    public static func issue(issueKey: String) -> JIRAIssue? {
        let result = JIRASession.sharedSession.get("issue/\(issueKey)", params: JIRAQueryParams())
        if let data = result.data {
            print(data)
            return JIRAIssue(json: JSON(data))
        }
        return nil
    }

    public static func search(query: String) -> [JIRAIssue] {
        let payload: JIRAPayload = [
            "jql": query,
            "startAt": 0,
            "maxResults": 100
        ]
        let result = JIRASession.sharedSession.post("search", params: JIRAQueryParams(),
            payload: payload)
        let json = JSON(result.data ?? [])
        return json["issues"].arrayValue.map { JIRAIssue(json: $0) }
    }

}


// MARK: Active Record (Instance)

public extension JIRAIssue {

    internal var asDictionary: [String: AnyObject?] {
        return [
            "summary": summary,
            "issuetype": issueType.asDictionary as? AnyObject,
            "project": project?.asDictionary as? AnyObject
        ]
    }

    public func save() {
        let payload = [
            "fields": asDictionary
        ]
        if issueKey == nil {
            let result = JIRASession.sharedSession.post("issue", payload: payload as? JIRAPayload)
            print(result)
        } else {
            let result = JIRASession.sharedSession.put("issue/\(issueKey)",
                payload: payload as? JIRAPayload)
            print(result)
        }
    }

}
