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
    @State var captureFilter: String = ""
    @State var error: String = ""
    @State var numberPackets = 10
    var body: some View {
        HStack {
            Button("Start") {
                self.startButtonPress()
            }
            Picker(selection: $numberPackets, label: Text("")) {
                Text("Capture 1 Packet").tag(1)
                Text("Capture 10 Packets").tag(10)
                Text("Capture 100 Packets").tag(100)
                Text("Capture 1000 Packets").tag(1000)
                Text("Capture Infinite Packets").tag(0)
            }
            TextField("Capture Filter", text: $captureFilter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text(error)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Stop") {
                self.stopButtonPress()
            }
            Button("Erase Frames") {
                self.frames = []
            }
        }
    }
    
    func startButtonPress() {
        self.error = ""
        let interface = "en0"
        let packetCount: Int32 = Int32(numberPackets)
        let snaplen = 96
        let promiscuousMode = true
        do {
            etherCapture = try EtherCapture(interface: interface, count: packetCount, command: captureFilter, snaplen: snaplen, promiscuous: promiscuousMode) { frame in
                self.frames.append(frame)
            }
        } catch {
            self.error = error.localizedDescription
        }
    }
    func stopButtonPress() {
        self.error = ""
        etherCapture?.cancel()
    }
}

struct CaptureFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureFilterView(frames: .constant([Frame.sampleFrame]))
    }
}
