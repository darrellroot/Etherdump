//
//  UdpDetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct UdpDetailView: View {
    var udp: Udp
    var body: some View {
        VStack {
            HStack {
                Text("UDP").font(.headline)
                Spacer()
                VStack{
                    HStack{
                        Text(verbatim: "\(udp.sourcePort) > \(udp.destinationPort)")
                        Spacer()
                    }
                    HStack{
                        Text(verbatim: "Checksum: \(udp.checksum)")
                        Spacer()
                    }
                        
                }
            }
            PayloadView(payload: udp.payload)
            }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

struct UdpDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        guard case .udp(let udp) = Frame.sampleFrameUdp.layer4 else {
            print("fatal error")
            fatalError()
        }
        
        return UdpDetailView(udp: udp)
            .environmentObject(AppSettings()).font(.system(.body, design: .monospaced))
    }
}

