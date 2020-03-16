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
    var body: some View {
        VStack (spacing:6){
            HStack {
                Text("ICMP for IPv6").font(.headline)
                Spacer()
                Text(verbatim: "Type: \(icmp.type) Code: \(icmp.code)")
                Spacer()
            }
            HStack {
                Text(icmp.icmpType.typeString).font(.headline)
                Text("  ")
                Spacer()
                Text(icmp.icmpType.details)
                Spacer()
            }
            VStack{
            List(icmp.options, id: \.self) { option in
                Text(option.description)
                .font(self.appSettings.font)
            }
            PayloadView(payload: icmp.payload)
            }.font(appSettings.font)
                .cornerRadius(8).border(Color.black.opacity(0),
            width: 0).padding(0).background(Color.black.opacity(0.3))
            
            
            }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

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
