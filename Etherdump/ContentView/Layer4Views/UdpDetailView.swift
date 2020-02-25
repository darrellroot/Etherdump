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
                Text(verbatim: "\(udp.sourcePort) > \(udp.destinationPort)")
                Text(verbatim: "Checksum: \(udp.checksum)")
                Spacer()
            }
            PayloadView(payload: udp.payload)
            }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

/*struct TcpDetailView_Previews: PreviewProvider {
 static var previews: some View {
 TcpDetailView()
 }
 }*/
