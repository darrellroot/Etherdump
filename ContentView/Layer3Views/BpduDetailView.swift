//
//  BpduDetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/25/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct BpduDetailView: View {
    let bpdu: Bpdu

    var body: some View {
        return VStack {
            HStack {
                Text("BPDU").font(.headline)
                Spacer()
                Text("ProtocolID \(bpdu.protocolId) Version \(bpdu.bpduVersion) type \(bpdu.type) portRole \(bpdu.portRole)")
                Spacer()
            }
            Text("Flags: \(bpdu.flagsString)")
            Text("RootID \(bpdu.rootIdString) BridgeID \(bpdu.bridgeIdString)")
            Text(verbatim: "Age \(bpdu.age) MaxAge \(bpdu.maxAge) HelloTime \(bpdu.helloTime) ForwardDelay \(bpdu.forwardDelay) \(bpdu.data.count) bytes")
            Text(" ")
                
    }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

struct BpduDetailView_Previews: PreviewProvider {
    static var makeBpdu: Bpdu {
        let packetStream = "0180c20000004c710c19e3120027424203000002027c80004c710c19e30d0000000080004c710c19e30d80050000140002000f000000000000000000"
        let data = Frame.makeData(packetStream: packetStream)!
        let frame = Frame(data: data, timeval: timeval(), originalLength: 42)
        guard case .bpdu(let bpdu) = frame.layer3 else { fatalError() }
        return bpdu
    }

    static var previews: some View {
        BpduDetailView(bpdu: BpduDetailView_Previews.makeBpdu)
    }
}
