//
//  JIRAIssueType.swift
//  JIRACLI
//
//  Created by Eneko Alonso on 12/22/15.
//  Copyright © 2015 Hathway, Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct JIRAIssueType {

    var typeId: Int
    var name: String?
    var isSubtask: Bool?

    init(json: JSON) {
        typeId = json["id"].intValue
        name = json["name"].stringValue
        isSubtask = (json["subtask"].intValue == 1)
    }

    var asDictionary: [String: AnyObject?] {
        let id = String(typeId)
        return [
            "id": id
        ]
    }
    
}
