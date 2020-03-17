//
//  LldpDetailView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/26/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI
import PackageEtherCapture

struct LldpDetailView: View {
    let lldp: Lldp
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var highlight: Highlight
    
    var body: some View {
        return VStack(alignment: .leading) {
            HStack {
                Text("LLDP").font(.headline)
                Spacer()
                //Text("Version \(cdp.version)")
                //Text("TTL \(cdp.ttl)")
                //Text(verbatim: "Checksum \(cdp.checksum)")
            }
            ForEach(lldp.values, id: \.self) { value in
                Text(value.description)
                    .font(self.appSettings.font)
                    .onTapGesture {
                        self.highlight.start = value.startIndex
                        self.highlight.end = value.endIndex
                }
            }
    }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

struct LldpDetailView_Previews: PreviewProvider {
    static var makeLldp: Lldp? {
        let packetStream = "0180c200000e4c710c19e31288cc0207044c710c19e30d04040567693506020078fe0e00120f05001100110011001100110a0c7377697463683139653330640e0400140014100c0501c0a8002002000186a00010181102fe800000000000004e710cfffe19e30d02000186a0001018110220010db848021620000000000000000102000186a000fe060080c20100010000"
        let data = Frame.makeData(packetStream: packetStream)!
        let frame = Frame(data: data, timeval: timeval(), originalLength: 60)
        guard case .lldp(let lldp) = frame.layer3 else {
            print("test error not lldp")
            return nil
        }
        return lldp
    }

    static var previews: some View {
        LldpDetailView(lldp: LldpDetailView_Previews.makeLldp!).environmentObject(AppSettings())
    }
}
