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
    @EnvironmentObject var appSettings: AppSettings
     

    var body: some View {
        return VStack  (spacing:12){
            HStack {
            Text("BPDU").font(.headline)
            Spacer()
            }
            VStack (spacing:6){
                HStack{
                    Text("ProtocolID \(bpdu.protocolId) Version \(bpdu.bpduVersion) type \(bpdu.type) portRole \(bpdu.portRole)")
                    Spacer()
                }
                HStack{
                Text("Flags: \(bpdu.flagsString)")
                    Spacer()
                }
                HStack{
                Text("RootID \(bpdu.rootIdString)")
                    Spacer()
                }
                HStack{
                    Text("BridgeID \(bpdu.bridgeIdString)")
                    Spacer()
                }
                HStack{
                Text(verbatim: "Age \(bpdu.age) MaxAge \(bpdu.maxAge) HelloTime \(bpdu.helloTime) ForwardDelay \(bpdu.forwardDelay) \(bpdu.data.count) bytes")
                    Spacer()
                }
                
                
            }.font(appSettings.font)
                .padding().cornerRadius(8).border(Color.black.opacity(0),
                                                                      width: 0).padding(1).background(Color.black.opacity(0.4))
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
        .environmentObject(AppSettings())
    }
  
}
