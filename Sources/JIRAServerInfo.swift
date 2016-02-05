//
//  JIRAServerInfo.swift
//  SwiftyJIRA
//
//  Created by Eneko Alonso on 1/28/16.
//  Copyright © 2016 Hathway, Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct JIRAServerInfo {

    var baseUrl: String
    var version: String
    var versionNumbers: [Int]
    var buildNumber: Int
    var buildDate: NSDate?
    var serverTime: NSDate?
    var scmInfo: String
    var buildPartnerName: String
    var serverTitle: String

    public init(json: JSON) {
        baseUrl = json["baseUrl"].stringValue
        version = json["version"].stringValue
        versionNumbers = json["versionNumbers"].arrayValue.map { $0.intValue }
        buildNumber = json["buildNumber"].intValue

        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-mm-dd'T'hh:mm:ss.sssZZZ"  // "2016-01-27T07:30:52.026+0000"
        buildDate = formatter.dateFromString(json["buildDate"].stringValue)
        serverTime = formatter.dateFromString(json["serverTime"].stringValue)
        scmInfo = json["scmInfo"].stringValue
        buildPartnerName = json["buildPartnerName"].stringValue
        serverTitle = json["serverTitle"].stringValue
    }

}

public extension JIRAServerInfo {

    public static func serverInfo() -> JIRAServerInfo? {
        let result = JIRASession.sharedSession.get("serverInfo", params: ["doHealthCheck": false])
        switch result {
        case .Success(let data, _):
            return JIRAServerInfo(json: JSON(data!))
        case.Failure(let error, _, _):
            print(error)
            return nil
        }
    }

}
