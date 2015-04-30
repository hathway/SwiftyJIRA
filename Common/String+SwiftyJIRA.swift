//
//  String+SwiftyJIRA.swift
//  SwiftyJIRA
//
//  Created by Eneko Alonso on 4/22/15.
//  Copyright (c) 2015 Hathway, Inc. All rights reserved.
//

import Foundation

extension String {
    
    /// Percent escape value to be added to a URL query value as specified in RFC 3986
    ///
    /// This percent-escapes all characters besize the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Return precent escaped string.
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString("-._~")
        return self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
    }
}
