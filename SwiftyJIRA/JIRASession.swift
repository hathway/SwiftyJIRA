//
//  JIRASession.swift
//  Screenshots
//
//  Created by Eneko Alonso on 8/29/14.
//  Copyright (c) 2014 Hathway. All rights reserved.
//

import Foundation

private var settings: [String : String]? = nil

typealias JIRARequestCallback = (AnyObject?, NSURLResponse?, NSError?) -> Void


class JIRASession: NSObject {

    class func initialize(host:String, version:String, username:String, password:String) {
        settings = ["host": host, "version": version, "user": username, "pass": password]
    }
    
    class func get(path: String, params: [String:AnyObject]?, callback: JIRARequestCallback) {
        let request = self.request(path, params: params)
        if request == nil {
            callback(nil, nil, NSError(domain: "JIRASession", code: -1, userInfo: ["error":"Settings not set"]))
            return
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request!) {(data, response, error) in
            if error != nil {
                callback(nil, response, error)
                return
            }

            //            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            let (json: AnyObject?, error) = self.parse(data)
            callback(json, response, error)
        }
        task.resume()
    }

    class func post(path: String, params: [String:AnyObject]?, payload: [String:AnyObject]?, callback: JIRARequestCallback) {
        let request = self.request(path, params: params)
        if request == nil {
            callback(nil, nil, NSError(domain: "JIRASession", code: -1, userInfo: ["error":"Settings not set"]))
            return
        }
        
        request!.HTTPMethod = "POST"
        
        if payload != nil {
            var err: NSError?
            request!.HTTPBody = NSJSONSerialization.dataWithJSONObject(payload!, options: nil, error: &err)
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request!) {(data, response, error) in
            if error != nil {
                callback(nil, response, error)
                return
            }
            
            //            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            let (json: AnyObject?, error) = self.parse(data)
            callback(json, response, error)
        }
        task.resume()
    }

    private class func request(urlPath: String, params: [String:AnyObject]?) -> NSMutableURLRequest? {
        if settings == nil {
            return nil
        }
        
        var url = NSURL(string:settings!["host"]!)!
            .URLByAppendingPathComponent("/rest/api/")
            .URLByAppendingPathComponent(settings!["version"]!)
            .URLByAppendingPathComponent(urlPath)
            
        if let paramString = params?.stringFromHttpParameters() {
            if let urlString = url.absoluteString?.stringByAppendingString("?\(paramString)") {
                url = NSURL(string: urlString)!
            }
        }

        println(url)
        
        let login = NSString(format: "%@:%@", settings!["user"]!, settings!["pass"]!).dataUsingEncoding(NSUTF8StringEncoding)
        let base64Login = login!.base64EncodedStringWithOptions(nil)
        
        let request = NSMutableURLRequest(URL: url)
        request.addValue("Basic \(base64Login)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }

    private class func parse(data: NSData) -> (AnyObject?, NSError?) {
        var error: NSError?
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error)
        if error != nil {
            println(error?.localizedDescription)
        }
        return (json, error)
    }
    
}
