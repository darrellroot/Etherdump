//
//  Layer4DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/31/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Layer4DetailView: View {
    //@Binding var frame: Frame?
    @Binding var frame: Frame?
    var body: some View {
        if let frame = frame, let layer4 = frame.layer4 {
            switch layer4 {
                
            case .tcp(let tcp):
                return AnyView(TcpDetailView(tcp: tcp))
            case .udp(let udp):
                return AnyView(UdpDetailView(udp: udp))
            case .unknown(let unknown):
                return AnyView(Text("layer 4 protocol unknown"))
            }
        } else {
            return AnyView(Text("layer 4 decode not implemented"))
        }
        //Text(frame?.layer4?.verboseDescription ?? "Error displaying layer-4 header")
    }
}

struct Layer4DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Layer4DetailView(frame: .constant(Frame.sampleFrame))
    }
}
