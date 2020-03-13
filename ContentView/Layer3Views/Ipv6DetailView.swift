//
//  Ipv6DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Ipv6DetailView: View {
    let ipv6: IPv6
    var body: some View {
        let flowLabelHex = String(format: "%x",ipv6.flowLabel).uppercased()

        return VStack {
            HStack {
                Text("IPv6").font(.headline)
                Spacer()
                Text("\(ipv6.sourceIP.debugDescription) > \(ipv6.destinationIP.debugDescription)")
                Text("NextHeader \(ipv6.nextHeader)")
                Text("Hop Limit \(ipv6.hopLimit)")
                Spacer()
            }
            HStack {
                Text("Traffic Class: \(ipv6.trafficClass)")
                Text("FlowLabel: 0x\(flowLabelHex)")
                Text(verbatim: "PayloadLength: \(ipv6.payloadLength)")
                Text("Padding: \(ipv6.padding.count) Bytes")
            }
        }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

struct ipv6DetailView_Previews: PreviewProvider {
    static var makeIpv6: IPv6? {
        let packetStream = "685b35890a04b07fb95d8ed286dd620d78a900200639260014061400049c00000000000023132601064748021620d5ae46fbf6c7a15401bbf0f198953ced5030c49a8011011623d200000101080a0243f4b91f79a97d"
        let data = Frame.makeData(packetStream: packetStream)!
        let frame = Frame(data: data, timeval: timeval(), originalLength: 60)
        guard case .ipv6(let ipv6) = frame.layer3 else {
            print("test error not ipv6")
            return nil
        }
        return ipv6
    }

    static var previews: some View {
        Ipv6DetailView(ipv6: ipv6DetailView_Previews.makeIpv6!)
    }
}
