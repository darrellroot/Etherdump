//
//  HelpView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/24/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI

struct HelpView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        VStack {
            Text("\(BuildConfiguration.appName) Help").font(.title)
            Text(" ")
            VStack(alignment: .leading) {
                Text("\(BuildConfiguration.appName) is a tool to view ethernet frame captures.")
                Text(" ")
                Text("You can import a .pcap or .pcapng packet capture from another tool using the \"File->Import PCAP\" menu item")
                Text(" ")
                Text("The full \"Etherdump\" version downloadable from https://etherdump.net supports live packet capture on the MacOS network interface.  The full \"Etherdump\" version is notarized by Apple but is not sandboxed.").fixedSize(horizontal: false, vertical: true).lineLimit(4)
                Text("The \"Etherdump Lite\" version available in the MacOS App Store does not support live packet capture, because that functionality is not compatible with the sandbox security required by the MacOS App Store").fixedSize(horizontal: false, vertical: true).lineLimit(4)
            }
        }.font(appSettings.font)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView().environmentObject(AppSettings())
    }
}
