//
//  filterEnumerations.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import Foundation

enum FilterIpVersion: String, Hashable, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    case any
    case ipv4
    case ipv6
    case nonIp
}
