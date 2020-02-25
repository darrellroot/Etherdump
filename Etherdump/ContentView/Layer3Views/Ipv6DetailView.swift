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
            }
        }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

/*struct ipv6DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Ipv6DetailView()
    }
}*/
