//
//  CdpDetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/26/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct CdpDetailView: View {
    let cdp: Cdp
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var highlight: Highlight
    var body: some View {
        
        VStack {
            HStack {
                Text("CDP").font(.headline)
                Spacer()
                Text("Version \(cdp.version)")
                    .onTapGesture {
                        self.highlight.start = self.cdp.startIndex[.version]
                        self.highlight.end = self.cdp.endIndex[.version]
                }
                Text("TTL \(cdp.ttl)")
                    .onTapGesture {
                        self.highlight.start = self.cdp.startIndex[.ttl]
                        self.highlight.end = self.cdp.endIndex[.ttl]
                }
                Text(verbatim: "Checksum \(cdp.checksum.hex4)")
                    .onTapGesture {
                        self.highlight.start = self.cdp.startIndex[.checksum]
                        self.highlight.end = self.cdp.endIndex[.checksum]
                }
            }
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    ForEach(cdp.values, id: \.self) { value in
                        Text(value.description)
                            .font(self.appSettings.font)
                            .onTapGesture {
                                self.highlight.start = value.startIndex
                                self.highlight.end = value.endIndex
                        }
                    }
                }
                Spacer()
            }
        }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

struct CdpDetailView_Previews: PreviewProvider {
    static var makeCdp: Cdp? {
        let packetStream = "01000ccccccc4c710c19e31200cdaaaa0300000c200002b469530001001034633731306331396533306400020049000000030101cc0004c0a800200208aaaa0300000086dd0010fe800000000000004e710cfffe19e30d0208aaaa0300000086dd001020010db84802162000000000000000010003000767693500040008000000290005000c322e342e352e373100060028436973636f2053473235302d303820285049443a53473235302d30382d4b39292d565344000a00060001000b0005010012000500001300050000140010737769746368313965333064"
        let data = Frame.makeData(packetStream: packetStream)!
        let frame = Frame(data: data, timeval: timeval(), originalLength: 60)
        guard case .cdp(let cdp) = frame.layer3 else {
            print("test error not cdp")
            return nil
        }
        return cdp
    }
    
    static var previews: some View {
        CdpDetailView(cdp: CdpDetailView_Previews.makeCdp!).environmentObject(AppSettings())
    }
}
