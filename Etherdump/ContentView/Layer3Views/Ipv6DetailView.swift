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
    var body: some View {
        let flowLabelHex = String(format: "%x",ipv6.flowLabel).uppercased()

        return VStack (spacing:12){
            HStack {
                Text("IPv6").font(.headline)
                Spacer()
            }
            VStack(spacing:6){
                HStack{ Text("\(ipv6.sourceIP.debugDescription) >")
                    Spacer()
                }
                HStack{
                Text("\(ipv6.destinationIP.debugDescription)")
                    Spacer()
                }
                HStack{
                Text("NextHeader \(ipv6.nextHeader)")
                    Spacer()
                }
                HStack{
                Text("Hop Limit \(ipv6.hopLimit)")
                Spacer()
                }
            
            HStack {
                Text("Traffic Class: \(ipv6.trafficClass)")
                Spacer()
            }
            HStack{
                Text("FlowLabel: 0x\(flowLabelHex)")
                Spacer()
            }
            HStack{
                Text(verbatim: "PayloadLength: \(ipv6.payloadLength)")
                Spacer()
            }
            HStack{
                Text("Padding: \(ipv6.padding.count) Bytes")
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
