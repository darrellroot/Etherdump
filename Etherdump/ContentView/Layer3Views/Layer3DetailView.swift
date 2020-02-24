//
//  Layer3DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/31/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Layer3DetailView: View {
    @Binding var frame: Frame?
    var body: some View {
        if let frame = frame  {
            let layer3 = frame.layer3
            switch layer3 {
                
            case .ipv4(let ipv4):
                return AnyView(Ipv4DetailView(ipv4: ipv4))
            case .ipv6(let ipv6):
                return AnyView(Ipv6DetailView(ipv6: ipv6))
            case .unknown(let unknown):
                return AnyView(Text("unknown"))
            }
        } else {
            return AnyView(Text("should not get here"))
        }
        //Text(frame?.layer4?.verboseDescription ?? "Error displaying layer-4 header")
    }
}

struct Layer3DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Layer3DetailView(frame: .constant(Frame.sampleFrame))
    }
}
