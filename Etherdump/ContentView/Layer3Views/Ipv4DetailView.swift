//
//  Ipv4DetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/7/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct Ipv4DetailView: View {
    let ipv4: IPv4
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var highlight: Highlight
    var body: some View {
        return VStack (spacing:12){
            HStack {
                Text("IPv4").font(.headline)
                    .onTapGesture {
                        self.highlight.start = self.ipv4.startIndex[.version]
                        self.highlight.end = self.ipv4.endIndex[.version]
                }
                Spacer()
            }
            VStack (spacing:6){
                HStack{
                    Text(ipv4.sourceIP.debugDescription)
                        .onTapGesture {
                            self.highlight.start = self.ipv4.startIndex[.sourceIP]
                            self.highlight.end = self.ipv4.endIndex[.sourceIP]
                    }
                    Text(">")
                    Text(ipv4.destinationIP.debugDescription)
                        .onTapGesture {
                            self.highlight.start = self.ipv4.startIndex[.destinationIP]
                            self.highlight.end = self.ipv4.endIndex[.destinationIP]
                    }
                    Spacer()
                }
                HStack{
                Text("IP Protocol \(ipv4.ipProtocol)")
                        .onTapGesture {
                            self.highlight.start = self.ipv4.startIndex[.ipProtocol]
                            self.highlight.end = self.ipv4.endIndex[.ipProtocol]
                    }
                    Spacer()
                }
                HStack{
                Text("TTL \(ipv4.ttl)")
                        .onTapGesture {
                            self.highlight.start = self.ipv4.startIndex[.ttl]
                            self.highlight.end = self.ipv4.endIndex[.ttl]
                    }
                Spacer()
                }
            HStack {
                Text("DSCP: \(ipv4.dscp)")
                    .onTapGesture {
                        self.highlight.start = self.ipv4.startIndex[.dscp]
                        self.highlight.end = self.ipv4.endIndex[.dscp]
                }
                Spacer()
            }
                Group{
                    HStack {
                Text("ECN: \(ipv4.ecn)")
                    .onTapGesture {
                        self.highlight.start = self.ipv4.startIndex[.ecn]
                        self.highlight.end = self.ipv4.endIndex[.ecn]
                    }
                    Spacer()
                    }
                    HStack{
                    
                Text("Header Length: \(ipv4.ihl * 4) bytes")
                    .onTapGesture {
                        self.highlight.start = self.ipv4.startIndex[.ihl]
                        self.highlight.end = self.ipv4.endIndex[.ihl]
                    }
                Spacer()
                    }
                    HStack{
                Text(verbatim: "Header checksum: \(ipv4.headerChecksum)")
                    .onTapGesture {
                        self.highlight.start = self.ipv4.startIndex[.headerChecksum]
                        self.highlight.end = self.ipv4.endIndex[.headerChecksum]
                    }
                Spacer()
                    }
            }
            HStack{
                Text("TotalLength: \(ipv4.totalLength)")
                    .onTapGesture {
                        self.highlight.start = self.ipv4.startIndex[.totalLength]
                        self.highlight.end = self.ipv4.endIndex[.totalLength]
                }
                Spacer()
            }
            HStack{
                if ipv4.dontFragmentFlag { Text("DontFrag")
                        .onTapGesture {
                            self.highlight.start = self.ipv4.startIndex[.flags]
                            self.highlight.end = self.ipv4.endIndex[.flags]
                    }
                }
                if ipv4.moreFragmentsFlag { Text("MoreFrag")
                        .onTapGesture {
                            self.highlight.start = self.ipv4.startIndex[.flags]
                            self.highlight.end = self.ipv4.endIndex[.flags]
                    }
                }
                Spacer()
            }
            HStack{
                Text("FragmentOffset: \(ipv4.fragmentOffset)")
                    .onTapGesture {
                        self.highlight.start = self.ipv4.startIndex[.fragmentOffset]
                        self.highlight.end = self.ipv4.endIndex[.fragmentOffset]
                }
                Spacer()
            }
            if ipv4.options != nil {
                HStack{
                    Text("Options: \(ipv4.options!.hexdump)")
                        .onTapGesture {
                            self.highlight.start = self.ipv4.startIndex[.options]
                            self.highlight.end = self.ipv4.endIndex[.options]
                    }
                    Spacer()
                }
            }
            HStack{
                Text("Padding: \(ipv4.padding.count) Bytes")
                    .onTapGesture {
                        self.highlight.start = self.ipv4.startIndex[.padding]
                        self.highlight.end = self.ipv4.endIndex[.padding]
                }
                Spacer()
            }
            }.font(appSettings.font)
                .padding().cornerRadius(8).border(Color.black.opacity(0),
            width: 0).padding(1).background(Color.black.opacity(0.4))
           
            
        }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

struct Ipv4DetailView_Previews: PreviewProvider {
    static var makeIpv4: IPv4? {
        let packetStream = "685b35890a04c869cd2c0d50080045000034000040004006b959c0a80010c0a8000ac001de7ebc1aa99e868a316380100804203100000101080a872fd3281be79ab6"
        let data = Frame.makeData(packetStream: packetStream)!
        let frame = Frame(data: data, timeval: timeval(), originalLength: 60)
        guard case .ipv4(let ipv4) = frame.layer3 else {
            print("test error not ipv4")
            return nil
        }
        return ipv4
    }

    static var previews: some View {
        Ipv4DetailView(ipv4: Ipv4DetailView_Previews.makeIpv4!)
        .environmentObject(AppSettings())
    }
}
