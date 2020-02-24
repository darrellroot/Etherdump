//
//  ContentView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/30/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture




struct ContentView: View {
    let showCapture: Bool
    //@Environment(\.font) var font
    @EnvironmentObject var appSettings: AppSettings
    //@ObservedObject var appSettings: AppSettings
    @State var frames: [Frame] = []
    @State var activeFrame: Frame? = nil
    @State var layer3Filter: Layer3Filter = .any
    @State var layer4Filter: Layer4Filter = .any
    @State var portFilterA: String = ""
    @State var portFilterB: String = ""
    let appDelegate = NSApplication.shared.delegate as! AppDelegate
    
    init(frames: [Frame] = [], showCapture: Bool) {

        //init(frames: [Frame] = [], showCapture: Bool, appSettings: AppSettings) {
        self.showCapture = showCapture
        //self.appSettings = appSettings
        _frames = State<[Frame]>(initialValue: frames)
    }
    var body: some View {
        VStack(spacing: 0) {
            if showCapture { CaptureFilterView(frames: self.$frames) }
            DisplayFilterView(layer3Filter: $layer3Filter, layer4Filter: $layer4Filter, portFilterA: $portFilterA, portFilterB: $portFilterB)
            FrameSummaryView(frames: $frames,activeFrame:  $activeFrame, layer3Filter: $layer3Filter, layer4Filter: $layer4Filter, portFilterA: $portFilterA, portFilterB: $portFilterB)
            if activeFrame != nil {
                Layer2DetailView(frame: $activeFrame)
            }
            if activeFrame != nil {
                Layer3DetailView(frame: $activeFrame)
            }
            if activeFrame != nil {
                Layer4DetailView(frame: $activeFrame)
            }
            Text(activeFrame?.hexdump ?? "")
        }//.frame(maxWidth: .infinity, maxHeight: .infinity)
            //.frame(idealWidth: 1000, idealHeight: 1000)
            .font(appSettings.font)
            .onCommand(#selector(AppDelegate.exportPcap(_:))) {
            debugPrint("export Pcap")
                self.appDelegate.exportPcap(frames: self.frames)

        }

    }}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView(frames: [Frame.sampleFrame], showCapture: true, appSettings: AppSettings())
        ContentView(frames: [Frame.sampleFrame], showCapture: false).environmentObject(AppSettings())

        
    }
}
