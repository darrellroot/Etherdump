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

    var body: some View {
        VStack {
            CaptureFilterView(frames: self.$frames)
            Text("Display Filter")
            FrameSummaryView(frames: self.$frames)
            Text("Packet Detail")
            Text("Packet Hexdump")
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
