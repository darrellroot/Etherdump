//
//  UInt16+extensions.swift
//  
//
//  Created by Darrell Root on 3/4/20.
//

import Foundation

extension UInt8 {
    var hex: String {
        return String(format: "0x%x",self)
    }
    var plainhex: String {
        if self == 0x0 {
            return "00"
        } else if self < 0x10 {
            return String(format: "0%x",self)
        } else {
            return String(format: "%x",self)
        }
    }
}
