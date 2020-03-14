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
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var highlight: Highlight
    @Binding var frames: [Frame]
    var filteredFrames: [Frame]
    @Binding var activeFrame: Frame?
    @Binding var layer3Filter: Layer3Filter
    @Binding var layer4Filter: Layer4Filter
    @Binding var portFilterA: String
    @Binding var portFilterB: String
    
    var body: some View {
        List(self.filteredFrames) { frame in
            HStack {
                Text("\(frame.frameNumber) \(frame.description)")
                .font(self.appSettings.font)
                //.padding(4).overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.primary.opacity(0.6), lineWidth: 2))
                    .padding(4).overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.primary.opacity(0.6), lineWidth: frame.id == self.activeFrame?.id ? 4 : 2))
                .onTapGesture {
                    self.activeFrame = frame
                    self.highlight.start = nil
                    self.highlight.end = nil
                }
                Spacer()
            }
        }.padding().background(Color.purple.opacity(0.7))
    }
}

/*struct FrameSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        FrameSummaryView(frames: .constant([Frame.sampleFrame]),activeFrame: .constant(Frame.sampleFrame),layer3Filter: .constant(.any), layer4Filter: .constant(.any), portFilterA: .constant(""), portFilterB: .constant(""))
    }
}*/
