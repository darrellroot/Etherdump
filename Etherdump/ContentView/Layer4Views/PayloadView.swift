//
//  PayloadView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct PayloadView: View {
    //@EnvironmentObject var appSettings: AppSettings
    var payload: Data
    var body: some View {
        HStack {
            Text("Payload").font(.headline)
            Text("\(payload.count) Bytes")
            Spacer()
            Text(payload.hexdump)
            Spacer()
        }.cornerRadius(8).border(Color.gray.opacity(0.7), width: 2).padding()
    }
}

struct PayloadView_Previews: PreviewProvider {
    

    static var previews: some View {
        guard case .udp(let udp) = Frame.sampleFrameUdp.layer4 else {
            print("fatal error")
            fatalError()
        }
        
        return PayloadView(payload: udp.payload)
            .environmentObject(AppSettings()).font(.system(.body, design: .monospaced))
    }
}
