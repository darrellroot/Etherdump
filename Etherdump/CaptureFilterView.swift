//
//  CaptureFilterView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/30/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture
import PackageEtherCaptureC

struct CaptureFilterView: View {
    @State var etherCapture: EtherCapture? = nil
    @Binding var frames: [Frame]
    var body: some View {
        HStack {
            Button("Start") {
                self.startButtonPress()
            }
            Button("Stop") {
                
            }
            
        }
    }
    
    func startButtonPress() {
        let interface = "en0"
        let packetCount: Int32 = 10
        let expression = "icmp or icmp6"
        let snaplen = 96
        let promiscuousMode = true
        do {
            etherCapture = try EtherCapture(interface: interface, count: packetCount, command: expression, snaplen: snaplen, promiscuous: promiscuousMode) { frame in
                self.frames.append(frame)
            }
        } catch {
            print("\(error)")
        }
    }
}

struct CaptureFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureFilterView(frames: .constant([Frame.sampleFrame]))
    }
}
