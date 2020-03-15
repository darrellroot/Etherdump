//
//  String+extensions.swift
//  Etherdump
//
//  Created by Darrell Root on 3/15/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import Foundation
import Network
extension String {
    // IPv4 address "1.1" is considered "valid". That's bad
    var validIPv4: IPv4Address? {
        let dotCount = self.filter {$0 == "."}.count
        guard dotCount == 3 else {
            return nil
        }
        guard let ipv4 = IPv4Address(self) else {
            return nil
        }
        return ipv4
    }
}
