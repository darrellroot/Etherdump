//
//  FrameDetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 3/15/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct FrameDetailView: View {
    @Binding var activeFrame: Frame?
    
    var body: some View {
        ScrollView {
            if activeFrame != nil {
                Layer2DetailView(frame: $activeFrame)
            }
            if activeFrame != nil {
                Layer3DetailView(frame: $activeFrame)
            }
            if activeFrame != nil {
                Layer4DetailView(frame: $activeFrame)
            }
            if activeFrame != nil {
                FrameHexViewHolder(frame: $activeFrame).layoutPriority(1.0)
            }
        }
    }
}

struct FrameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FrameDetailView(activeFrame: .constant(Frame.sampleFrame))
    }
}
