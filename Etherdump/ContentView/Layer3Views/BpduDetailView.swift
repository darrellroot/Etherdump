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

/*struct BpduDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BpduDetailView()
    }
}*/
