//
//  Icmp4DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Icmp4DetailView: View {
    var icmp: Icmp4
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var highlight: Highlight
    var body: some View {
        VStack (spacing:6){
            HStack {
                VStack {
                    Text("ICMP for IPv4").font(.headline)
                    Text(icmp.icmpType.typeString).font(.headline)
                        .onTapGesture {
                            self.highlight.start = self.icmp.startIndex[.type]
                            self.highlight.end = self.icmp.endIndex[.type]
                    }
                }
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Text(verbatim: "Type: \(icmp.type)")
                            .onTapGesture {
                                self.highlight.start = self.icmp.startIndex[.type]
                                self.highlight.end = self.icmp.endIndex[.type]
                        }
                        Text("Code: \(icmp.code)")
                            .onTapGesture {
                                self.highlight.start = self.icmp.startIndex[.code]
                                self.highlight.end = self.icmp.endIndex[.code]
                        }
                        Text("Checksum \(icmp.checksum.hex4)")
                            .onTapGesture {
                                self.highlight.start = self.icmp.startIndex[.checksum]
                                self.highlight.end = self.icmp.endIndex[.checksum]
                        }
                    }
                    Icmp4TypeView(icmp: icmp)
                }
                Spacer()
            }
            PayloadView(payload: icmp.payload)
                    .onTapGesture {
                        self.highlight.start = self.icmp.startIndex[.payload]
                        self.highlight.end = self.icmp.endIndex[.payload]
                }
            .font(appSettings.font)
                .padding().cornerRadius(8).border(Color.black.opacity(0),
            width: 0).padding(1).background(Color.black.opacity(0.4))
            
            }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

struct Icmp4DetailView_Previews: PreviewProvider {
 static var previews: some View {
        guard case .icmp4(let icmp4) = Frame.sampleFrameIcmp4.layer4 else {
            print("fatal error")
            fatalError()
        }
        
        return Icmp4DetailView(icmp: icmp4)
            .environmentObject(AppSettings()).font(.system(.body, design: .monospaced))
    }
 }
