//
//  ArpDetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 3/4/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct ArpDetailView: View {
    let arp: Arp

    var body: some View {
        return VStack {
            HStack {
                Text(arp.operation.rawValue).font(.headline)
                Spacer()
                Text("Sender \(arp.senderEthernet)  \(arp.senderIp.debugDescription)")
                Spacer()
            }
            HStack {
                Text("Target \(arp.targetEthernet) \(arp.targetIp.debugDescription)")
            }
            HStack {
                Text("hwType \(arp.hardwareType) hwSize \(arp.hardwareSize)")
            }
            HStack {
                Text("protocolType \(arp.protocolType.hex) protocolSize \(arp.protocolSize)")
            }
                
    }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

/*struct BpduDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BpduDetailView()
    }
}*/
