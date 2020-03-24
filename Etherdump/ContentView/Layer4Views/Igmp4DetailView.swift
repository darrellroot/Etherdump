//
//  Igmp4DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Igmp4DetailView: View {
    var igmp: Igmp4
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var highlight: Highlight
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("IGMPv\(igmp.version)").font(.headline)
                Text(igmp.type.description).font(.headline)
                    .onTapGesture {
                        self.highlight.start = self.igmp.startIndex[.type]
                    self.highlight.end = self.igmp.endIndex[.type]
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Group: \(igmp.address.debugDescription)")
                    .onTapGesture {
                        self.highlight.start = self.igmp.startIndex[.address]
                        self.highlight.end = self.igmp.endIndex[.address]
                }
                Text("Checksum: \(igmp.checksum.hex)")
                    .onTapGesture {
                        self.highlight.start = self.igmp.startIndex[.checksum]
                        self.highlight.end = self.igmp.endIndex[.checksum]
                }
                if self.igmp.queryInterval != nil {
                    Text("QueryInterval: \(self.igmp.queryInterval!)")
                        .onTapGesture {
                            self.highlight.start = self.igmp.startIndex[.queryIntervalCode]
                            self.highlight.end = self.igmp.endIndex[.queryIntervalCode]
                    }
                }
                if self.igmp.numberOfSources != nil {
                    Text("NumberOfSources: \(self.igmp.numberOfSources!)")
                        .onTapGesture {
                        self.highlight.start = self.igmp.startIndex[.numberOfSources]
                        self.highlight.end = self.igmp.endIndex[.numberOfSources]
                    }
                }
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Max Response Time: \(igmp.maxResponseTime) seconds")
                    .onTapGesture {
                        self.highlight.start = self.igmp.startIndex[.maxResponseTime]
                        self.highlight.end = self.igmp.endIndex[.maxResponseTime]
                }
                if self.igmp.supressFlag != nil {
                    Text("SupressFlag: \(self.igmp.supressFlag!.description)")
                        .onTapGesture {
                            self.highlight.start = self.igmp.startIndex[.flags]
                            self.highlight.end = self.igmp.endIndex[.flags]
                    }
                } else {
                    Text(" ")
                }
                if self.igmp.querierRobustness != nil {
                    Text("QuerierRobustness: \(self.igmp.querierRobustness!)")
                        .onTapGesture {
                        self.highlight.start = self.igmp.startIndex[.flags]
                        self.highlight.end = self.igmp.endIndex[.flags]
                    }
                }
                if self.igmp.numberOfSources ?? 0 > 0 {
                    Text("Sources:")
                    ForEach((self.igmp.sources), id: \.self) { source in
                        Text(source.debugDescription)
                    }.onTapGesture {
                        self.highlight.start = self.igmp.startIndex[.sources]
                        self.highlight.end = self.igmp.endIndex[.sources]
                    }
                }
            }
        }.font(appSettings.font)
            .padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
        
    }
}

/*struct Igmp4DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        guard case .igmp4(let igmp) = Frame.sampleFrameUdp.layer4 else {
            print("fatal error")
            fatalError()
        }
        
        return UdpDetailView(udp: udp)
            .environmentObject(AppSettings()).font(.system(.body, design: .monospaced))
    }
}*/

