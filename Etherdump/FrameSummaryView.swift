//
//  FrameSummaryView.swift
//  Etherdump
//
//  Created by Darrell Root on 1/31/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct FrameSummaryView: View {
    @Binding var frames: [Frame]
    var body: some View {
        List(frames) { frame in
            Text(frame.description)
        }
    }
}

struct FrameSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        FrameSummaryView(frames: .constant([Frame.sampleFrame]))
    }
}
