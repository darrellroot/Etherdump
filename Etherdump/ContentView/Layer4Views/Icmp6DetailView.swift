//
//  Icmp6DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 3/2/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Icmp6DetailView: View {
    var icmp: Icmp6
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var highlight: Highlight
    
    var body: some View {
        VStack {
            HStack (spacing:6){
                VStack(alignment: .leading) {
                    Text("ICMP for IPv6").font(.headline)
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
                    }
                    HStack {
                        Icmp6TypeView(icmp: icmp)
                    }
                    VStack(alignment: .leading) {
                        ForEach(icmp.options, id: \.self) { option in
                            Text(option.description)
                                .font(self.appSettings.font)
                                .onTapGesture {
                                    self.highlight.start = option.startIndex
                                    self.highlight.end = option.endIndex
                            }
                        }
                    }
                }
                Spacer()
            }
            PayloadView(payload: icmp.payload)
                .padding(8).background(Color.black.opacity(0.3))
                .onTapGesture {
                    self.highlight.start = self.icmp.startIndex[.payload]
                    self.highlight.end = self.icmp.endIndex[.payload]
            }

        }// Outer VStack
        .padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }// var body
}// struct Icmp6DetailView

struct Icmp6DetailView_Previews: PreviewProvider {
    static var previews: some View {
        guard case .icmp6(let icmp6) = Frame.sampleFrameIcmp6.layer4 else {
            print("fatal error")
            fatalError()
        }
        
        return Icmp6DetailView(icmp: icmp6)
            .environmentObject(AppSettings()).font(.system(.body, design: .monospaced))
    }
}
