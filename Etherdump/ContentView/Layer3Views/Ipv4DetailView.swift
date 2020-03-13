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
    var body: some View {
        return VStack (spacing:12){
            HStack {
                Text("IPv4").font(.headline)
                Spacer()
            }
            VStack (spacing:6){
                HStack{ Text("\(ipv4.sourceIP.debugDescription) > \(ipv4.destinationIP.debugDescription)")
                    Spacer()
                }
                HStack{
                Text("IP Protocol \(ipv4.ipProtocol)")
                    Spacer()
                }
                HStack{
                Text("TTL \(ipv4.ttl)")
                Spacer()
                }
            
            HStack {
                Text("DSCP: \(ipv4.dscp)")
                Spacer()
            }
                Group{
                    HStack {
                Text("ECN: \(ipv4.ecn)")
                    Spacer()
                    }
                    HStack{
                    
                Text("Header Length: \(ipv4.ihl * 5) bytes")
                Spacer()
                    }
                    HStack{
                Text(verbatim: "Header checksum: \(ipv4.headerChecksum)")
                Spacer()
                    }
            }
            HStack{
                Text("TotalLength: \(ipv4.totalLength)")
                Spacer()
            }
            HStack{
                if ipv4.dontFragmentFlag { Text("DontFrag")}
                if ipv4.moreFragmentsFlag { Text("MoreFrag")}
                Spacer()
            }
            HStack{
                Text("FragmentOffset: \(ipv4.fragmentOffset)")
                Spacer()
            }
            if ipv4.options != nil {
                HStack{
                    Text("Options: \(ipv4.options!.hexdump)")
                    Spacer()
                }
            }
            HStack{
                Text("Padding: \(ipv4.padding.count) Bytes")
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
