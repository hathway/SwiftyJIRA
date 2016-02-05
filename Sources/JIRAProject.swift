//
//  JIRAProject.swift
//  JIRACLI
//
//  Created by Eneko Alonso on 12/23/15.
//  Copyright © 2015 Hathway, Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct JIRAProject {

    var projectId: String
    var projectKey: String?

    init(json: JSON) {
        projectId = json["id"].stringValue
    }

    internal var asDictionary: [String: AnyObject?] {
        return [
            "id": projectId
        ]
    }

}
