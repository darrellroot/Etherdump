//
//  filterEnumerations.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import Foundation

enum Layer2Filter: String, Hashable, CaseIterable, Identifiable {
    var id: String { rawValue }
    case any = "Any Layer-2"
    case arp = "ARP"
    case bpdu = "BPDU"
    case cdp = "CDP"
    case lldp = "LLDP"
}

enum Layer3Filter: String, Hashable, CaseIterable, Identifiable {
    var id: String { rawValue }
    case any = "Any Layer-3"
    case ipv4 = "IPv4"
    case ipv6 = "IPv6"
    case nonIp = "Non-IP Protocols"
}

enum Layer4Filter: String, Hashable, CaseIterable, Identifiable {
    var id: String { rawValue }
    case any = "Any Layer-4"
    case tcp = "TCP"
    case udp = "UDP"
    case icmp = "ICMP"
}
