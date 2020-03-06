//
//  AboutView.swift
//  Etherdump
//
//  Created by Darrell Root on 2/24/20.
//  Copyright © 2020 net.networkmom. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var appSettings: AppSettings
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown"
    
    var body: some View {
        VStack {
            Text("About \(BuildConfiguration.appName)").font(.title)
            Text(" ")
            Text("Version \(appVersion) Build \(buildNumber)")
            Text("feedback@networkmom.net")
            Text(" ")
            VStack(alignment: .leading) {
                Group {
                Text("\(BuildConfiguration.appName) is a tool to view ethernet frame captures.")
                Text(" ")
                Text("The full \"Etherdump\" version, downloadable from https://networkmom.net/etherdump, supports live packet captures on  MacOS network interfaces.  The full \"Etherdump\" version is notarized by Apple but is not sandboxed.").fixedSize(horizontal: false, vertical: true).lineLimit(4)
                Text(" ")
                Text("The full \"Etherdump\" version requires read-access to /dev/bfp*.  See Help for details.")
                Text(" ")
                Text("The \"Etherdump Lite\" version, available in the MacOS App Store, does not support live packet captures. Live packet capture functionality is not compatible with  sandbox security required by the MacOS App Store.  \"Etherdump Lite\" supports importing .pcap and .pcapng files captured with other tools (such as tcpdump or Wireshark)").fixedSize(horizontal: false, vertical: true).lineLimit(4)
                }
                Group {
                Text(" ")
                Text("\"Etherdump\" and \"Etherdump Lite\" are Open Source at https://github.com/darrellroot/Etherdump").font(.headline)
                Text(" ")
                Text("Etherdump uses the following Open Source swift packages:").font(.headline)
                Text(" ")
                    Group {Text("PackageEtherCapture").font(.headline) + Text(" https://github.com/darrellroot/PackageEtherCapture for capturing and decoding Ethernet frames")}.fixedSize(horizontal: false, vertical: true).lineLimit(2)
                }
                Group {
                    Text("PackageSwiftPcapng").font(.headline) + Text(" https://github.com/darrellroot/PackageSwiftPcapng for opening and saving .pcap and .pcapng files")}.fixedSize(horizontal: false, vertical: true).lineLimit(2)
                Group {
                    Text("Swift-Log API").font(.headline) + Text(" https://github.com/apple/swift-log")
                Text(" ")
                }
                Group {
                    Text("Frame Decodes Supported In Version 1.0 February 2020").font(.headline)
                    Text("Layer 2:  Ethernet, 802.3, 802.2 SNAP")
                    Text("Layer 2+: ARP, BPDU, CDP, LLDP")
                    Text("Layer 3:  IPv4, IPv6")
                    Text("Layer 4:  TCP, UDP, ICMPv4, ICMPv6")
                    Text(" ")
                    Text("Etherdump and PackageEtherCapture welcome pull requests for additional decodes.  But all submissions will be carefully reviewed.").fixedSize(horizontal: false, vertical: true).lineLimit(2)
                }
            }
            }.font(appSettings.font).padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().environmentObject(AppSettings())
    }
}
