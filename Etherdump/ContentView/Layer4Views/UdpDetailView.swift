//
//  UdpDetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct UdpDetailView: View {
    var udp: Udp
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var highlight: Highlight
    var body: some View {
        VStack (spacing:6){
            HStack {
                Text("UDP").font(.headline)
                Spacer()
            }
            HStack{
                VStack(spacing:6){
                    HStack{
                        Text(verbatim: "\(udp.sourcePort)")
                            .onTapGesture {
                                self.highlight.start = self.udp.startIndex[.sourcePort]
                                self.highlight.end = self.udp.endIndex[.sourcePort]
                        }
                        Text(">")
                        Text("\(udp.destinationPort)")
                            .onTapGesture {
                                self.highlight.start = self.udp.startIndex[.destinationPort]
                                self.highlight.end = self.udp.endIndex[.destinationPort]
                        }
                        Spacer()
                    }
                    HStack{
                        Text(verbatim: "Checksum: \(udp.checksum)")
                            .onTapGesture {
                                self.highlight.start = self.udp.startIndex[.checksum]
                                self.highlight.end = self.udp.endIndex[.checksum]
                        }
                        Spacer()
                    }
                    HStack{
                        PayloadView2(payload: udp.payload)
                            .onTapGesture {
                                self.highlight.start = self.udp.startIndex[.payload]
                                self.highlight.end = self.udp.endIndex[.payload]
                        }
                        Spacer()
                    }
                    
                }
                
            }.font(appSettings.font)
                .padding().cornerRadius(8).border(Color.black.opacity(0),
                                                  width: 0).padding(1).background(Color.black.opacity(0.4))
            //       HStack{
            // PayloadView(payload: udp.payload)
            //         Spacer()
            //    }.background(Color.black.opacity(0.4))
        }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
        
    }
}

struct UdpDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        guard case .udp(let udp) = Frame.sampleFrameUdp.layer4 else {
            print("fatal error")
            fatalError()
        }
        
        return UdpDetailView(udp: udp)
            .environmentObject(AppSettings()).font(.system(.body, design: .monospaced))
    }
}

