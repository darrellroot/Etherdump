//
//  Ipv4DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Ipv4DetailView: View {
    let ipv4: IPv4
    var body: some View {
        return VStack {
            HStack {
                Text("IPv4").font(.headline)
                Spacer()
                Text("\(ipv4.sourceIP.debugDescription) > \(ipv4.destinationIP.debugDescription)")
                Text("IP Protocol \(ipv4.ipProtocol)")
                Text("TTL \(ipv4.ttl)")
                Spacer()
            }
            HStack {
                Text("DSCP: \(ipv4.dscp)")
                Text("ECN: \(ipv4.ecn)")
                Text("Header Length: \(ipv4.ihl * 5) bytes")
                Text(verbatim: "Header checksum: \(ipv4.headerChecksum)")
            }
            HStack {
                Text("TotalLength: \(ipv4.totalLength)")
                if ipv4.dontFragmentFlag { Text("DontFrag")}
                if ipv4.moreFragmentsFlag { Text("MoreFrag")}
                Text("FragmentOffset: \(ipv4.fragmentOffset)")
                if ipv4.options != nil { Text("Options: \(ipv4.options!.hexdump)") }
                Text("Padding: \(ipv4.padding.count) Bytes")
            }
        }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

/*struct Ipv4DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Ipv4DetailView()
    }
}*/
