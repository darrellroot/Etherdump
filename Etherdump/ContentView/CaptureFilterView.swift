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
import Network

struct CaptureFilterView: View {
    @State var etherCapture: EtherCapture? = nil
    @EnvironmentObject var appSettings: AppSettings
    @Binding var frames: [Frame]
    @Binding var activeFrame: Frame?
    @State var captureFilter: String = ""
    @State var error: String = ""
    @State var numberPackets = 10
    @State var interface: String = ""
    init(frames: Binding<[Frame]>, interface: String, activeFrame: Binding<Frame?>) {
        self._frames = frames
        self._activeFrame = activeFrame
        self.interface = interface
    }
    var body: some View {
        HStack() {
            Text("Capture Controls:").fontWeight(.semibold)
            Button("Start") {
                self.startButtonPress()
            }
            Picker(selection: self.$interface, label: Text("")) {
                ForEach(appSettings.interfaces, id: \.self) { interfaceName in
                    Text(interfaceName)
                }
            }.onAppear {
                self.interface = self.appSettings.interfaces.first ?? "en0"
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
                self.activeFrame = nil
            }
        }.padding()
            .background(Color.green.opacity(0.7))
    }
    
    func startButtonPress() {
        self.error = ""
        //let interface = "en0"
        let packetCount: Int32 = Int32(numberPackets)
        let snaplen = 65535
        let promiscuousMode = true
        do {
            etherCapture = try EtherCapture(interface: self.interface, count: packetCount, command: captureFilter, snaplen: snaplen, promiscuous: promiscuousMode) { frame in
                self.frames.append(frame)
            }
        } catch {
            self.error = "\(error)" // error.localizedDescription
        }
    }
    func stopButtonPress() {
        self.error = ""
        etherCapture?.cancel()
    }
}

struct CaptureFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureFilterView(frames: .constant([Frame.sampleFrame]), interface: "en0", activeFrame: .constant(Frame.sampleFrame))
    }
}
