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

    var body: some View {
        return VStack {
            HStack {
                Text("LLDP").font(.headline)
                Spacer()
                //Text("Version \(cdp.version)")
                //Text("TTL \(cdp.ttl)")
                //Text(verbatim: "Checksum \(cdp.checksum)")
            }
            List(lldp.values, id: \.self) { value in
                Text(value.description)
                    .font(self.appSettings.font)
            }
    }.padding().cornerRadius(8).border(Color.green.opacity(0.7), width: 2).padding()
    }
}

/*struct CdpDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CdpDetailView()
    }
}*/
