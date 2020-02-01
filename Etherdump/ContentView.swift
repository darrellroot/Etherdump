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
    @State var frames: [Frame] = []
    @State var activeFrame: Frame? = nil

    var body: some View {
        VStack {
            CaptureFilterView(frames: self.$frames)
            Text("Display Filter")
            FrameSummaryView(frames: self.$frames,activeFrame:  self.$activeFrame)
            if activeFrame != nil {
                Layer2DetailView(frame: self.$activeFrame)
            }
            if activeFrame != nil {
                Layer3DetailView(frame: self.$activeFrame)
            }
            if activeFrame != nil {
                Layer4DetailView(frame: self.$activeFrame)
            }

            Text(activeFrame?.hexdump ?? "")
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
