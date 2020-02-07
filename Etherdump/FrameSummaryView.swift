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
    @Binding var activeFrame: Frame?
    @Binding var layer3Filter: FilterIpVersion
    
    var filteredFrames: [Frame] {
        var outputFrames = frames
        switch layer3Filter {
            
        case .any:
            break
        case .ipv4:
            for (position,frame) in outputFrames.enumerated().reversed() {
                if case .ipv4(_) = frame.layer3 {
                //if false {
                    continue
                } else {
                    outputFrames.remove(at: position)
                }
            }
        case .ipv6:
            for (position,frame) in outputFrames.enumerated().reversed() {
                if case .ipv6(_) = frame.layer3 {
                    continue
                } else {
                    outputFrames.remove(at: position)
                }
            }
        case .nonIp:
            for (position,frame) in outputFrames.enumerated().reversed() {
                if case .ipv4(_) = frame.layer3 {
                    outputFrames.remove(at: position)
                } else if case .ipv6(_) = frame.layer3 {
                    outputFrames.remove(at: position)
                } else {
                    continue
                }
            }
        }
        return outputFrames
    }
    var body: some View {
        List(self.filteredFrames) { frame in
            Button(frame.description) {
                self.activeFrame = frame
            }
        }
    }
}

struct FrameSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        FrameSummaryView(frames: .constant([Frame.sampleFrame]),activeFrame: .constant(Frame.sampleFrame),layer3Filter: .constant(.any))
    }
}
