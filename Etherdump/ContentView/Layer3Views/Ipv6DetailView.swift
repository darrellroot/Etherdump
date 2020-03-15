//
//  Ipv6DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Ipv6DetailView: View {
    let ipv6: IPv6
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var highlight: Highlight
    var body: some View {
        let flowLabelHex = String(format: "%x",ipv6.flowLabel).uppercased()

        return VStack (spacing:12){
            HStack {
                Text("IPv6").font(.headline)
                    .onTapGesture {
                        self.highlight.start = self.ipv6.startIndex[.version]
                        self.highlight.end = self.ipv6.endIndex[.version]
                }
                Spacer()
            }
            VStack(spacing:6){
                HStack{
                    Text(ipv6.sourceIP.debugDescription)
                        .onTapGesture {
                            self.highlight.start = self.ipv6.startIndex[.sourceIP]
                            self.highlight.end = self.ipv6.endIndex[.sourceIP]
                    }
                    Text(">")
                    Spacer()
                }
                HStack{
                    Text(ipv6.destinationIP.debugDescription)
                        .onTapGesture {
                            self.highlight.start = self.ipv6.startIndex[.destinationIP]
                            self.highlight.end = self.ipv6.endIndex[.destinationIP]
                    }
                    Spacer()
                }
                HStack{
                Text("NextHeader \(ipv6.nextHeader)")
                    .onTapGesture {
                            self.highlight.start = self.ipv6.startIndex[.nextHeader]
                            self.highlight.end = self.ipv6.endIndex[.nextHeader]
                    }
                    Spacer()
                }
                HStack{
                Text("Hop Limit \(ipv6.hopLimit)")
                    .onTapGesture {
                            self.highlight.start = self.ipv6.startIndex[.hopLimit]
                            self.highlight.end = self.ipv6.endIndex[.hopLimit]
                    }
                Spacer()
                }
            
            HStack {
                Text("Traffic Class: \(ipv6.trafficClass)")
                    .onTapGesture {
                        self.highlight.start = self.ipv6.startIndex[.trafficClass]
                        self.highlight.end = self.ipv6.endIndex[.trafficClass]
                }
                Spacer()
            }
            HStack{
                Text("FlowLabel: 0x\(flowLabelHex)")
                    .onTapGesture {
                        self.highlight.start = self.ipv6.startIndex[.flowLabel]
                        self.highlight.end = self.ipv6.endIndex[.flowLabel]
                }
                Spacer()
            }
            HStack{
                Text(verbatim: "PayloadLength: \(ipv6.payloadLength)")
                    .onTapGesture {
                        self.highlight.start = self.ipv6.startIndex[.payloadLength]
                        self.highlight.end = self.ipv6.endIndex[.payloadLength]
                }
                Spacer()
            }
            HStack{
                Text("Padding: \(ipv6.padding.count) Bytes")
                    .onTapGesture {
                        self.highlight.start = self.ipv6.startIndex[.padding]
                        self.highlight.end = self.ipv6.endIndex[.padding]
                }
                Spacer()
            }
            }.font(appSettings.font).padding().cornerRadius(8).border(Color.black.opacity(0),
            width: 0).padding(1).background(Color.black.opacity(0.4))
            }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

struct ipv6DetailView_Previews: PreviewProvider {
    static var makeIpv6: IPv6? {
        let packetStream = "685b35890a04b07fb95d8ed286dd620d78a900200639260014061400049c00000000000023132601064748021620d5ae46fbf6c7a15401bbf0f198953ced5030c49a8011011623d200000101080a0243f4b91f79a97d"
        let data = Frame.makeData(packetStream: packetStream)!
        let frame = Frame(data: data, timeval: timeval(), originalLength: 60)
        guard case .ipv6(let ipv6) = frame.layer3 else {
            print("test error not ipv6")
            return nil
        }
        return ipv6
    }

    static var previews: some View {
        Ipv6DetailView(ipv6: ipv6DetailView_Previews.makeIpv6!)
        .environmentObject(AppSettings())
    }
}
