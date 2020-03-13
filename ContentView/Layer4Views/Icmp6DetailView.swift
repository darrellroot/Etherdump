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
        VStack {
            HStack {
                Text("ICMP for IPv6").font(.headline)
                Spacer()
                Text(verbatim: "Type: \(icmp.type) Code: \(icmp.code)")
                Spacer()
            }
            HStack {
                Text(icmp.icmpType.typeString).font(.headline)
                Spacer()
                Text(icmp.icmpType.details)
                Spacer()
            }
            List(icmp.options, id: \.self) { option in
                Text(option.description)
                    .font(self.appSettings.font)
            }
            PayloadView(payload: icmp.payload)
            }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

/*struct TcpDetailView_Previews: PreviewProvider {
 static var previews: some View {
 TcpDetailView()
 }
 }*/
