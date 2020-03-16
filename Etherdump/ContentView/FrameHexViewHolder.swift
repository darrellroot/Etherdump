//
//  FrameHexViewHolder.swift
//  Etherdump
//
//  Created by Darrell Root on 3/15/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct FrameHexViewHolder: View {
    @Binding var frame: Frame?
    @EnvironmentObject var highlight: Highlight

    var body: some View {
        VStack(alignment: .leading) {
            Text("Frame Hex View").font(.headline)
            HStack {
                Spacer()
                FrameHexView(frame: $frame)
                Spacer()
            }
        }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

struct FrameHexViewHolder_Previews: PreviewProvider {
    static var previews: some View {
        FrameHexViewHolder(frame: .constant(Frame.sampleFrame)).environmentObject(Highlight())
    }
}
